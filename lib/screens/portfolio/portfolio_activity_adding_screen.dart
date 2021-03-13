import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';

class PortfolioActivityAddingScreen extends StatefulWidget {
  @override
  _PortfolioActivityAddingScreenState createState() =>
      _PortfolioActivityAddingScreenState();
}

class _PortfolioActivityAddingScreenState
    extends State<PortfolioActivityAddingScreen> {
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
            child: Text("Activity adding screen"),
          ),
        ),
      ),
    );
  }
}
