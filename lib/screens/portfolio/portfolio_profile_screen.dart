import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';

class PortfolioProfileScreen extends StatefulWidget {
  @override
  _PortfolioProfileScreenState createState() => _PortfolioProfileScreenState();
}

class _PortfolioProfileScreenState extends State<PortfolioProfileScreen> {
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
            child: Text("Profile Screen"),
          ),
        ),
      ),
    );
  }
}
