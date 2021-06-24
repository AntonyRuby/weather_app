part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationUnInitialized extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnInitialized";
  }
}

class AuthenticationUnAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnAuthenticated";
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationAuthenticated";
  }
}

class SplashScreenState extends AuthenticationState {
  @override
  String toString() {
    return "SplashScreenState";
  }
}

class NoInternetConnectionState extends AuthenticationState {
  @override
  String toString() {
    return "NoInternetConnectionState";
  }
}
