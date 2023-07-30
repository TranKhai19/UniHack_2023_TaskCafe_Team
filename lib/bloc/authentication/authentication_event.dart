part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LogInRequested extends AuthenticationEvent{
  final String email;
  final String password;
  const LogInRequested({
    required this.email,
    required this.password,
});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginRequested { email: $email }';
}

class GoogleSignInRequested extends AuthenticationEvent {
  const GoogleSignInRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GoogleSignInRequested';
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LogoutRequested';
}
