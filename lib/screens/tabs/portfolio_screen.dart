import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/bloc/theme/theme_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_menu_screen.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  ProfileBloc profileBloc;
  PortfolioBloc portfolioBloc;

  StreamSubscription<PortfolioState> portfolioBlocSub;

  int _currentTab = 4;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    portfolioBloc = PortfolioBloc(profileBloc: profileBloc);
    portfolioBloc.add(PortfolioEventInit());
    initSubscriptions();
    super.initState();
  }

  @override
  dispose() {
    portfolioBlocSub.cancel();
    super.dispose();
  }

  initSubscriptions() {
    portfolioBlocSub = portfolioBloc.listen((state) {
      if (state is PortfolioStateError) {
        var snakBar = SnackBar(
          content: Text(state.error),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
      } else if (state is PortfolioStateAppCreated) {
        Navigator.pop(context);
        var snakBar = SnackBar(
          content: Text('Достижение успешно отправлено на проверку'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
      } else if (state is PortfolioStateEventSent) {
        Navigator.pop(context);
        var snakBar = SnackBar(
          content: Text('Мероприятие успешно отправлено на проверку'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
      }
    });
  }

  List<Widget> widgetsList = [
    Container(),
    Container(),
    Container(),
    Container(),
    PortfolioMenuScreen(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider.value(
        value: portfolioBloc,
        child: Scaffold(
          body: BlocBuilder<PortfolioBloc, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioStateLoading) {
                return LoadingWidget();
              }
              if (state is PortfolioStateNeedInit) {
                return PortfolioPreviewScreen();
              }
              if (state is PortfolioStateLoaded) {
                _currentTab = 4;
              }
              return PortfolioMenuScreen();
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
    List<Color> colors;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeStateLight) {
          colors = [Color(0xFF72C6EF), Color(0xFF004E8F), Color(0xFF004E8F)];
        } else {
          colors = [Color(0xFF17212B), Color(0xFF17212B).withOpacity(0.8)];
        }
        return buildPreviewScreen(colors, state, context);
      },
    );
  }

  buildPreviewScreen(
      List<Color> colors, ThemeState theme, BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Center(
            child: Stack(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: colors)),
                  ),
                  SvgPicture.asset(
                    'assets/ArtProfile.svg',
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 50,
                    left: 50,
                    right: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Портфолио",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 30,
                    right: 30,
                    child: Container(
                      height: 50,
                      width: 250,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          context
                              .read<PortfolioBloc>()
                              .add(PortfolioEventCreateProfile());
                        },
                        child: Text(
                          "Присоединиться",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: theme is ThemeStateLight
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
