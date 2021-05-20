part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileStateLoading extends ProfileState {
  @override
  String toString() => "ProfileStateNotAuthorized";
}


class ProfileStateNotAuthorized extends ProfileState {
  @override
  String toString() => "ProfileStateNotAuthorized";
}

class ProfileStateAuthorized extends ProfileState {
  final UserModel user;

  ProfileStateAuthorized({this.user});

  @override
  String toString() => "ProfileStateAuthorized";
}

class ProfileStateError extends ProfileState {
  final Error error;

  ProfileStateError({this.error});

  @override
  String toString() => "ProfileStateError";
}
