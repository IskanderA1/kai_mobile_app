import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_achiev_adding_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_activity_adding_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_global_rating_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_menu_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_profile_screen.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    portfolioBloc.pickItem(PortfMenuItems.Menu);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: portfolioBloc.itemStream,
            initialData: portfolioBloc.defaultItem,
            builder:
                // ignore: missing_return
                (BuildContext context, AsyncSnapshot<PortfMenuItems> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.index) {
                  /*Preview, NewAchiev, ActivityAdding, GlobalRating, Menu, Profile*/
                  case 0:
                    return PortfolioPreviewScreen();
                    break;
                  case 1:
                    return PortfolioAchievAddingScreen();
                    break;
                  case 2:
                    return PortfolioActivityAddingScreen();
                    break;
                  case 3:
                    return PortfolioGlobalRatingScreen();
                    break;
                  case 4:
                    return PortfolioMenuScreen();
                    break;
                  case 5:
                    return PortfolioProfileScreen();
                    break;
                  default:
                    return PortfolioPreviewScreen();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class PortfolioPreviewScreen extends StatelessWidget {
  const PortfolioPreviewScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Превью портфолио"),
                      Container(
                        height: 50,
                        width: 250,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            portfolioBloc.pickItem(PortfMenuItems.Menu);
                          },
                          child: Text(
                            "Присоединиться",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
