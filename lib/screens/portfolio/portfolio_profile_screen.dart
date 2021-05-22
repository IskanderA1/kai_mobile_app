import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';

class PortfolioProfileScreen extends StatefulWidget {
  @override
  _PortfolioProfileScreenState createState() => _PortfolioProfileScreenState();
}

class _PortfolioProfileScreenState extends State<PortfolioProfileScreen> {
  PortfolioBloc portfolioBloc;

  @override
  void initState() {
    portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          //portfolioBloc.add(PortfolioEventNavigate(tab: PortfMenuItems.Menu));
        },
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
