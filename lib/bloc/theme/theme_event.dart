part of 'theme_bloc.dart';

enum ThemeItem { LIGHT, DARK }

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeEventInitialize extends ThemeEvent {
  @override
  String toString() => 'Theme initialize';
}

class ThemeEventChangeTheme extends ThemeEvent {
  ThemeEventChangeTheme(this.item);
  final ThemeItem item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'Theme initialize';
}
