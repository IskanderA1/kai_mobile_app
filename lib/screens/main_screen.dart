import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/bottom_navbar_bloc.dart';
import 'package:kai_mobile_app/screens/tabs/messeager_screen.dart';
import 'package:kai_mobile_app/screens/tabs/news_screen.dart';
import 'file:///C:/Users/79172/AndroidStudioProjects/kai_mobile_app/lib/screens/util/auth_check_screen.dart';
import 'package:kai_mobile_app/screens/tabs/srevice_screen.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    //_bottomNavBarBloc = bottomNavBarBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context,AsyncSnapshot<NavBarItem> snapshot){
            switch(snapshot.data){
              case NavBarItem.NEWS:
                return NewsScreen();
              case NavBarItem.SERVICE:
                return ServiceScreen();
              case NavBarItem.MESSENGER:
                return MessengerScreen();
              case NavBarItem.PROFILE:
                return AuthCheckScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[100], spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                backgroundColor: Style.Colors.mainColor,
                iconSize: 20,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.shifting,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                fixedColor: Style.Colors.titleColor,
                currentIndex: snapshot.data.index,
                onTap: bottomNavBarBloc.pickItem,
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
                    icon: Icon(EvaIcons.messageSquareOutline),
                    activeIcon: Icon(EvaIcons.messageSquare),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: Icon(EvaIcons.personOutline),
                    activeIcon: Icon(EvaIcons.person),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
