import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';

class PortfolioGlobalRatingScreen extends StatefulWidget {
  @override
  _PortfolioGlobalRatingScreenState createState() =>
      _PortfolioGlobalRatingScreenState();
}

class _PortfolioGlobalRatingScreenState
    extends State<PortfolioGlobalRatingScreen> {
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
        onWillPop: () async{
          //portfolioBloc.add(PortfolioEventNavigate(tab: PortfMenuItems.Menu));
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
