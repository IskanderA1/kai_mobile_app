import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kai_mobile_app/model/week_item.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';

part 'week_event.dart';
part 'week_state.dart';

class WeekBloc extends Bloc<WeekEvent, WeekState> {
  WeekBloc(MobileRepository repository)
      : this._repository = repository,
        super(WeekStateLoading());

  final MobileRepository _repository;

  @override
  Stream<WeekState> mapEventToState(
    WeekEvent event,
  ) async* {
    if (event is WeekEventLoad) {
      yield* getCurrWeek();
    }
    else if (event is WeekEventPick){
      yield WeekStateLoaded(week: event.week);
    }
  }

  Stream<WeekState> getCurrWeek() async* {
    yield WeekStateLoading();
    int response;
    try {
      response = await _repository.getCurrWeek();
    } catch (e) {
      yield WeekStateError(error: e);
      return;
    }
    if (response == 1) {
      yield WeekStateLoaded(week: WeekItem.UNEVEN);
    } else {
      yield WeekStateLoaded(week: WeekItem.EVEN);
    }
  }
}
