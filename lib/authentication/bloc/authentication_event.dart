part of 'authentication_bloc.dart';

class AuthenticationEvent extends BaseEquatable {}

class AppStartedEvent extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class SessionLogout extends AuthenticationEvent {}
