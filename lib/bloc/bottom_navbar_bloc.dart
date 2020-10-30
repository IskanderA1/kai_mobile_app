

import 'dart:async';

enum NavBarItem{NEWS,SERVICE,MESSENGER, PROFILE}

class BottomNavBarBloc{

  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.NEWS;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.NEWS);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.SERVICE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.MESSENGER);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
final bottomNavBarBloc = BottomNavBarBloc();