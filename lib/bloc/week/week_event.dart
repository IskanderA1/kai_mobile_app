part of 'week_bloc.dart';

abstract class WeekEvent extends Equatable {
  const WeekEvent();

  @override
  List<Object> get props => [];
}

class WeekEventLoad extends WeekEvent {
  @override
  List<Object> get props => [];
}

class WeekEventPick extends WeekEvent{
  WeekEventPick({this.week});
  final WeekItem week;
  @override
  List<Object> get props => [week];
}
