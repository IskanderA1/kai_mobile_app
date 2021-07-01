part of 'getsemester_bloc.dart';

abstract class GetSemesterState extends Equatable {
  const GetSemesterState();

  @override
  List<Object> get props => [];
}

class GetSemesterStateLoading extends GetSemesterState {}

class GetSemesterStateLoaded extends GetSemesterState {
  GetSemesterStateLoaded({this.semesters});

  final List<SemestrModel> semesters;

  @override
  List<Object> get props => [semesters];
}

class GetSemesterStateError extends GetSemesterState {
  GetSemesterStateError({this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
