part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEventInitialize extends ProfileEvent {
  @override
  String toString() => "ProfileEventInitilize";
}

class ProfileEventLogout extends ProfileEvent {
  ProfileEventLogout({this.semesterNum});
  final int semesterNum;

  @override
  List<Object> get props => [semesterNum];

  @override
  String toString() => "ProfileEventLogout";
}
