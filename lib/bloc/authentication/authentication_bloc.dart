import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:unihack/data/repositories/person_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final PersonRepository _personRepository;
  AuthenticationBloc({required PersonRepository personRepository})
      : _personRepository = personRepository,
        super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogInRequested>(_onLogInRequested);
    on<GoogleSignInRequested>(_onGoogleLogInRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }
  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSingedIn = await _personRepository.isSignedIn();
      if (isSingedIn) {
        final uid = await _personRepository.getUserId();
        if (uid != null) {
          emit(AuthenticationAuthenticated(uid: uid));
        } else {
          emit(AuthenticationInitial());
        }
      } else {
        emit(AuthenticationInitial());
      }
    } catch (_) {
      emit(AuthenticationInitial());
    }
  }

  Future<void> _onLogInRequested(
      LogInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final String? uid = await _personRepository.signIn(email: event.email, password: event.password);
     
      Fluttertoast.showToast(msg: 'Login success');
      emit(AuthenticationAuthenticated(uid: uid));
    } catch (e) {
      emit(const AuthenticationUnauthenticated(error: "Login unsuccessful!!"));
   
    }
  }

  Future<void> _onGoogleLogInRequested(
      GoogleSignInRequested event, Emitter<AuthenticationState> emit) async {
    try {
      final UserCredential userCredential = await _personRepository.signInWithGoogle();

      if (userCredential.user != null) {
        final User user = userCredential.user!;
        emit(AuthenticationAuthenticated(uid: user.uid));
        print('User Google ${user.uid}');
      } else {
        emit(const AuthenticationUnauthenticated(error: "Failed to sign in with Google"));
      }

      
    } catch (e) {
      EasyLoading.showError("Login unsuccessful!");
      print(e);
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) async {
    await _personRepository.signOut();
    emit(Unauthenticated());
  }
}