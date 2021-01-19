import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/auth_user_bloc.dart';
import 'package:kai_mobile_app/bloc/bottom_navbar_bloc.dart';
import 'package:kai_mobile_app/bloc/day_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/theme_bloc.dart';
import 'package:kai_mobile_app/bloc/week_bloc.dart';
import 'package:kai_mobile_app/screens/tabs/news_screen.dart';
import 'package:kai_mobile_app/screens/tabs/srevice_screen.dart';
import 'package:kai_mobile_app/screens/util/auth_check_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    try {
      IO.Socket socket = IO.io("http://kaimobile.loliallen.com");
      socket.onConnect((_) {
        print('CONNECT');
        //socket.emit('add_like', '4542e123...312313');
      });
      socket.connect();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
      _firebaseMessaging.getToken().then((String token) {
        print("token $token");
        sendTokenToServer(token);
      });
    } catch (e) {
      print(e.toString());
    }
    themeBloc.getUserTheme();
    authBloc..authWithLocal();
    dayWeekBloc..getDay();
    getSemestrBloc..getSemestr();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    weekBloc..close();
    dayWeekBloc.close();
    serviceMenu.close();
    bottomNavBarBloc.close();
    getSemestrBloc.dispose();
    weekBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.NEWS:
                return NewsScreen();
              case NavBarItem.SERVICE:
                return ServiceScreen();
              // case NavBarItem.MESSENGER:
              //   return MessengerScreen();
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
            child: ClipRRect(
              child: BottomNavigationBar(
                //backgroundColor: Style.Colors.mainColor,
                iconSize: 20,
                //unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.shifting,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                //fixedColor: Style.Colors.titleColor,
                currentIndex: snapshot.data.index,
                onTap: (int i) {
                  bottomNavBarBloc.pickItem(i);
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
                    icon: Icon(EvaIcons.personOutline),
                    activeIcon: Icon(EvaIcons.person),
                  ),
                  // BottomNavigationBarItem(
                  //   label: "",
                  //   icon: Icon(EvaIcons.messageSquareOutline),
                  //   activeIcon: Icon(EvaIcons.messageSquare),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> sendTokenToServer(String token) async {
  var url = 'https://e0cf7973d18e.ngrok.io/api/device/new';
  var uuid = UniqueKey().toString();
  var response = await http
      .post(url, body: {'uuid': uuid, 'token': token, 'platform': 'android'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
