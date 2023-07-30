import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:unihack/data/models/person.dart';

class PersonRepository {
  final FirebaseAuth _firebaseAuth;
  final _logger = Logger('UserRepository');
  late StreamController<Person?> _userController;

  PersonRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      _logger.info('${record.level.name}: ${record.time}: ${record.message}');
    });
    _userController = StreamController<Person?>();
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      _userController.add(firebaseUser == null
          ? null
          : Person(
              uid: firebaseUser.uid,
              fullName: firebaseUser.displayName ?? '',
              email: firebaseUser.email ?? '',
              displayName: firebaseUser.displayName ?? '',
              photoUrl: firebaseUser.photoURL ?? '',
            ));
    });
  }
 
  Stream<Person?> get user => _userController.stream;

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e, stackTrace) {
      _logger.severe('Failed to sign up user:', e, stackTrace);
      return null;
    }
  }



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the user's information
    final User? user = userCredential.user;

    // Add user information to collectionUser
    if (user != null) {
      await addUserCollection(
        userID: user.uid,
        fullName: user.displayName!,
        email: user.email!,
        photoUrl: user.photoURL!,
        displayName: user.displayName!,
        phoneNumber: user.phoneNumber!,
      );
    }

    return userCredential;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;
      return user.uid;
    } catch (e, stackTrace) {
      _logger.severe('Failed to sign in user:', e, stackTrace);
      return null;
    }
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<Person?> getUser() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return Person(
          uid: currentUser.uid,
          fullName: currentUser.displayName ?? '',
          email: currentUser.email ?? '',
          displayName: currentUser.displayName ?? '',
          photoUrl: currentUser.photoURL ?? '');
    } else {
      return null;
    }
  }

  Future<String?> getUserId() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser?.uid;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isEmailVerified() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser!.emailVerified;
  }

  Future<void> reloadUser() async {
    final currentUser = _firebaseAuth.currentUser;
    await currentUser!.reload();
  }

  Future<void> sendEmailVerification() async {
    final currentUser = _firebaseAuth.currentUser;
    await currentUser!.sendEmailVerification();
  }

  Future<void> updateDisplayName(String displayName) async {
    final currentUser = _firebaseAuth.currentUser;
    await currentUser!.updateDisplayName(displayName);
  }

  Future<void> updatePhotoUrl(String photoUrl) async {
    final currentUser = _firebaseAuth.currentUser;
    await currentUser!.updatePhotoURL(photoUrl);
  }
}
Future<void> addUserCollection({
  required String userID,
  required String fullName,
  required String email,
  required String photoUrl,
  required String displayName,
  required String phoneNumber,
}) async {
  try {
    final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('Users');
    final userDoc = userCollection.doc(userID);
    final userData = {
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    };
    await userDoc.set(userData);
    print('User data added to Firestore collection successfully!');
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}