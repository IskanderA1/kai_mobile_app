import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/login/login_bloc.dart';
import 'package:kai_mobile_app/bloc/navigator/navigator_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/screens/services/service_menu_screen.dart';
import 'package:kai_mobile_app/screens/tabs/news_screen.dart';
import 'package:kai_mobile_app/screens/tabs/portfolio_screen.dart';
import 'package:kai_mobile_app/screens/tabs/profile_screen.dart';
import 'package:kai_mobile_app/screens/tabs/srevice_screen.dart';
import 'package:kai_mobile_app/screens/util/auth_screen.dart';

class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  NavigatorBloc navigatorBloc;
  ProfileBloc profileBloc;

  List<Widget> _containers = [
    NewsScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    initBlocs();
  }

  initBlocs() async {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    navigatorBloc.listen((state) {
      int currentInd = state.selectedTab;
      if (_containers[currentInd] is Container) {
        this._containers[currentInd] = _getWidgetForIndex(currentInd);
      }
    });
  }

  Widget _getWidgetForIndex(i) {
    switch (i) {
      case 0:
        return NewsScreen();
        break;
      case 1:
        return ServiceScreen();
        break;
      case 2:
        return PortfolioScreen();
        break;
      case 3:
        return ProfileScreen();
        break;
      default:
        return NewsScreen();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: profileBloc,
      builder: (context, state) {
        if (state is ProfileStateNotAuthorized) {
          return AuthScreen();
        }
        if (state is ProfileStateAuthorized) {
          return BlocBuilder<NavigatorBloc, NavigatorTabState>(
            cubit: navigatorBloc,
            builder: (context, state) {
              return Scaffold(
                  body: SafeArea(
                    child: IndexedStack(
                      index: state.selectedTab,
                      children: _containers,
                    ),
                  ),
                  bottomNavigationBar: Container(
                    child: ClipRRect(
                      child: BottomNavigationBar(
                        iconSize: 20,
                        unselectedFontSize: 9.5,
                        selectedFontSize: 9.5,
                        type: BottomNavigationBarType.fixed,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        currentIndex: state.selectedTab,
                        onTap: (int i) {
                          if (navigatorBloc.state ==
                              NavigatorTabState(selectedTab: 1)) {
                            serviceMenu.pickItem(10);
                          }
                          navigatorBloc
                              .add(NavigatorEventSelectTab(selectTab: i));
                        },
                        items: [
                          BottomNavigationBarItem(
                            label: "",
                            icon: Icon(EvaIcons.homeOutline),
                            activeIcon: Icon(EvaIcons.home),
                          ),
                          BottomNavigationBarItem(
                            label: "",
                            icon: Icon(EvaIcons.gridOutline),
                            activeIcon: Icon(EvaIcons.grid),
                          ),
                          BottomNavigationBarItem(
                            label: "",
                            icon: Icon(Icons.assessment_outlined),
                            activeIcon: Icon(Icons.assessment),
                          ),
                          BottomNavigationBarItem(
                            label: "",
                            icon: Icon(EvaIcons.personOutline),
                            activeIcon: Icon(EvaIcons.person),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          );
        }
        if (state is ProfileStateLoading) {
          return LoadingWidget();
        }
        return LoadingWidget();
      },
    );
  }
}
