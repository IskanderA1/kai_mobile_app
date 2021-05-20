/*import 'dart:async';

enum PortfMenuItems {
  Preview,
  NewAchiev,
  ActivityAdding,
  GlobalRating,
  Menu,
  Profile
}

class PortfolioNavigateBloc {
  final StreamController<PortfMenuItems> _portfolioController =
      StreamController<PortfMenuItems>.broadcast();

  PortfMenuItems defaultItem = PortfMenuItems.Menu;
  Stream<PortfMenuItems> get itemStream => _portfolioController.stream;

  backToMenu() {
    _portfolioController.sink.add(PortfMenuItems.Menu);
  }

  void pickItem(PortfMenuItems i) {
    _portfolioController.sink.add(i);
    /*switch (i) {
      case 0:
        _portfolioController.sink.add(PortfMenuItems.Menu);
        break;
      case 1:
        _portfolioController.sink.add(PortfMenuItems.NewAchiev);
        break;
      case 2:
        _portfolioController.sink.add(PortfMenuItems.ActivityAdding);
        break;
      case 3:
        _portfolioController.sink.add(PortfMenuItems.GlobalRating);
        break;
        case 4:
        _portfolioController.sink.add(PortfMenuItems.Profile);
        break;
      // case 3:
      //   _navBarController.sink.add(NavBarItem.MESSENGER);
      //   break;
    }*/
  }

  close() {
    _portfolioController?.close();
  }
}

PortfolioNavigateBloc portfolioBloc = PortfolioNavigateBloc();
*/