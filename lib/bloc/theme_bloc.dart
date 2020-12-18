import 'dart:async';

import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';

enum ThemeItem { LIGHT, DARK }

class ThemeBloc {
  final StreamController<ThemeItem> _themController =
      StreamController<ThemeItem>.broadcast();

  ThemeItem defaultItem = ThemeItem.LIGHT;
  Stream<ThemeItem> get itemStream => _themController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _themController.sink.add(ThemeItem.LIGHT);
        break;
      case 1:
        serviceMenu.backToMenu();
        _themController.sink.add(ThemeItem.DARK);
        break;
    }
  }

  close() {
    _themController?.close();
  }
}

final themeBloc = ThemeBloc();
