import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(MobileRepository repository)
      : this._repository = repository,
        super(null);

  final MobileRepository _repository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEventLogin) {
      yield* _auth(event.login, event.password);
    }
  }

  Stream<LoginState> _auth(String login, String password) async* {
    yield LoginStateLoading();
    try {
      UserResponse response = await _repository.userAuth(login, password);
      if (response != null && response.error == "" && response.user != null) {
        yield LoginStateAuthorized();
      } else {
        yield LoginStateNotAuthorized();
      }
    } catch (e) {
      print('LoginStateError $e');
      yield LoginStateError(error: e);
    }
  }
}
