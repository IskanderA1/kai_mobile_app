import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeStateLight());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeEventInitialize) {
      yield* getUserTheme();
    } else if (event is ThemeEventChangeTheme) {
      yield* pickItem(event.item);
    }
  }

  Stream<ThemeState> pickItem(ThemeItem item) async* {
    final prefs = await SharedPreferences.getInstance();
    if (item == ThemeItem.LIGHT) {
      prefs.setBool("userTheme", true);
      yield ThemeStateLight();
    } else {
      prefs.setBool("userTheme", false);
      yield ThemeStateDark();
    }
  }

  Stream<ThemeState> getUserTheme() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("userTheme") != null) {
      if (prefs.getBool("userTheme")) {
        yield ThemeStateLight();
      } else {
        yield ThemeStateDark();
      }
    } else {
      yield ThemeStateLight();
    }
  }
}
