part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatorEventSelectTab extends NavigatorEvent {
  final int selectTab;
  NavigatorEventSelectTab({this.selectTab});

  @override
  List<Object> get props => [selectTab];

  @override
  String toString() => "MainTabBarEventSelectTab {selectTab: $selectTab}";
}