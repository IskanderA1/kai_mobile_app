part of 'dayweek_bloc.dart';

abstract class DayWeekEvent extends Equatable {
  const DayWeekEvent();

  @override
  List<Object> get props => [];
}

class DayWeekEventInitialize extends DayWeekEvent {}

class DayWeekEventChange extends DayWeekEvent {
  DayWeekEventChange({this.day});
  final DayItem day;

  @override
  List<Object> get props => [day];
}
