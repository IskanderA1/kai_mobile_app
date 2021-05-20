part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final String login;
  final String password;

  LoginEventLogin({this.login, this.password});

  @override
  List<Object> get props => [login, password];

  @override
  String toString() => "LoginEventLogin {login: $login} ";
}
