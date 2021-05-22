part of 'navigator_bloc.dart';

class NavigatorTabState extends Equatable {
  final int selectedTab;
  NavigatorTabState({this.selectedTab});

  @override
  List<Object> get props => [selectedTab];

  @override
  String toString() =>
      "MainTabBarStateSelectedTab { selectedTab: $selectedTab }";
}