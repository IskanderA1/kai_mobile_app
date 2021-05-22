import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dayweek_event.dart';
part 'dayweek_state.dart';

enum DayItem { MO, TU, WE, TH, FR, SA }

class DayWeekBloc extends Bloc<DayWeekEvent, DayWeekState> {
  DayWeekBloc() : super(null);

  DayItem _current = DayItem.MO;

  DayItem get current => _current;

  @override
  Stream<DayWeekState> mapEventToState(
    DayWeekEvent event,
  ) async* {
    if (event is DayWeekEventInitialize) {
      yield* pickCurrendDay();
    } else if (event is DayWeekEventChange) {
      setCurrDay(event.day);
    }
  }

  Stream<DayWeekState> setCurrDay(DayItem dayItem) async* {
    yield DayWeeekStateLoaded(day: dayItem);
    _current = dayItem;
  }

  Stream<DayWeekState> pickCurrendDay() async* {
    DateTime date = DateTime.now();
    print("weekday = ${date.weekday}");
    DayItem currDay;
    switch (date.weekday) {
      case 1:
        currDay = DayItem.MO;
        break;
      case 2:
        currDay = DayItem.TU;
        break;
      case 3:
        currDay = DayItem.WE;
        break;
      case 4:
        currDay = DayItem.TH;
        break;
      case 5:
        currDay = DayItem.FR;
        break;
      case 6:
        currDay = DayItem.SA;
        break;
      case 7:
        currDay = DayItem.SA;
        break;
    }
    _current = currDay;
    yield DayWeeekStateLoaded(day: currDay);
  }
}
