part of 'week_bloc.dart';

abstract class WeekState extends Equatable {
  const WeekState();

  @override
  List<Object> get props => [];
}

class WeekStateLoading extends WeekState {}

class WeekStateLoaded extends WeekState {
  WeekStateLoaded({this.week});
  final WeekItem week;
  @override
  List<Object> get props => [week];
}

class WeekStateError extends WeekState {
  WeekStateError({this.error});
  final Error error;
  @override
  List<Object> get props => [error];
}