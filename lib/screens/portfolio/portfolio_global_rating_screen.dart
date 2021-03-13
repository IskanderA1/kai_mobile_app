import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';

class PortfolioGlobalRatingScreen extends StatefulWidget {
  @override
  _PortfolioGlobalRatingScreenState createState() =>
      _PortfolioGlobalRatingScreenState();
}

class _PortfolioGlobalRatingScreenState
    extends State<PortfolioGlobalRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => portfolioBloc.backToMenu(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Портфолио",
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Text(
              "Global rating screen",
            ),
          ),
        ),
      ),
    );
  }
}
