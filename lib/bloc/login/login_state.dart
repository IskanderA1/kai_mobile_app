part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStateNotAuthorized extends LoginState {
  @override
  String toString() => "LoginStateNotAuthorized";
}

class LoginStateLoading extends LoginState {
  @override
  String toString() => "LoginStateLoading";
}

class LoginStateAuthorized extends LoginState {
  @override
  String toString() => "LoginStateAuthorized";
}

class LoginStateError extends LoginState {
  final Error error;

  LoginStateError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "LoginStateError";
}