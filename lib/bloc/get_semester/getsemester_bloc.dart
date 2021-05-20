import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kai_mobile_app/model/semester_brs_model.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';

part 'getsemester_event.dart';
part 'getsemester_state.dart';

class GetSemesterBloc extends Bloc<GetSemesterEvent, GetSemesterState> {
  GetSemesterBloc(KaiRepository repository)
      : _repository = repository,
        super(GetSemesterStateLoading());

  KaiRepository _repository;

  @override
  Stream<GetSemesterState> mapEventToState(
    GetSemesterEvent event,
  ) async* {
    if (event is GetSemesterEventLoad) {
      yield* _getSemestr();
    }
  }

  Stream<GetSemesterState> _getSemestr() async* {
    yield GetSemesterStateLoading();
    try {
      final response = await _repository.getSemestr();
      yield GetSemesterStateLoaded(semesters: response);
    } catch (e) {
      yield GetSemesterStateError(error: e);
    }
  }
}
