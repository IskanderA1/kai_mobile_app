import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_global_rating_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_profile_screen.dart';

class PortfolioMenuScreen extends StatefulWidget {
  @override
  _PortfolioMenuScreenState createState() => _PortfolioMenuScreenState();
}

class _PortfolioMenuScreenState extends State<PortfolioMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Портфолио",
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                //height: 40,
                width: 250,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  heroTag: null,
                  onPressed: () {
                    ///return portfolio profile screen
                    portfolioBloc.pickItem(PortfMenuItems.Profile);
                  },
                  child: Text(
                    "Личные достижения",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                //height: 40,
                width: 250,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  heroTag: null,
                  onPressed: () {
                    ///return global rating screen
                    portfolioBloc.pickItem(PortfMenuItems.GlobalRating);
                  },
                  child: Text(
                    "Общий рейтинг",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                //height: 40,
                width: 250,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  heroTag: null,
                  onPressed: () {
                    ///return achiev adding
                    portfolioBloc.pickItem(PortfMenuItems.NewAchiev);
                  },
                  child: Text(
                    "Добавить достижения",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
