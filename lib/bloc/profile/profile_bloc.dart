import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';
import 'package:kai_mobile_app/model/user_model.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(MobileRepository repository)
      : this._repository = repository,
        super(null);

  final MobileRepository _repository;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileEventInitialize) {
      yield* _authWithLocal();
    } else if (event is ProfileEventLogout) {
      yield* _authLogOut(event.semesterNum);
    }
  }

  Stream<ProfileState> _authWithLocal() async* {
    yield ProfileStateLoading();
    try {
      UserResponse response = await _repository.userAuthLocal();
      if (response != null && response.user != null && response.error == "") {
        yield ProfileStateAuthorized(user: response.user);
      } else {
        yield ProfileStateNotAuthorized();
      }
    } catch (e) {
      yield ProfileStateError(error: e);
    }
  }

  Stream<ProfileState> _authLogOut(int semestrNum) async* {
    yield ProfileStateLoading();
    try {
      await _repository.userLogOut(semestrNum);
      yield ProfileStateNotAuthorized();
    } catch (e) {
      yield ProfileStateError(error: e);
    }
  }
}
