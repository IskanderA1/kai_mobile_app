part of 'dayweek_bloc.dart';

abstract class DayWeekState extends Equatable {
  const DayWeekState();

  @override
  List<Object> get props => [];
}

class DayWeeekStateLoaded extends DayWeekState {
  DayWeeekStateLoaded({this.day});
  final DayItem day;
  @override
  List<Object> get props => [day];
}
