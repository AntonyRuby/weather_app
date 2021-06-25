part of 'authentication_bloc.dart';

class AuthenticationState extends BaseEquatable {}

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

class NoInternetConnectionState extends AuthenticationState {
  @override
  String toString() {
    return "NoInternetConnectionState";
  }
}
