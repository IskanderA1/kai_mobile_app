import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_mobile_app/bloc/day_week/dayweek_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester/getsemester_bloc.dart';
import 'package:kai_mobile_app/bloc/login/login_bloc.dart';
import 'package:kai_mobile_app/bloc/navigator/navigator_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/bloc/theme/theme_bloc.dart';
import 'package:kai_mobile_app/bloc/week/week_bloc.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/screens/main_tabs_screen.dart';
import 'package:kai_mobile_app/screens/util/auth_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  ThemeBloc themeBloc;
  DayWeekBloc dayWeekBloc;
  GetSemesterBloc getSemestrBloc;
  WeekBloc weekBloc;
  ProfileBloc profileBloc;
  NavigatorBloc navigatorBloc;
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    initFirebase();
    initBlocs();
  }

  initBlocs() async {
    dayWeekBloc = DayWeekBloc()..add(DayWeekEventInitialize());
    getSemestrBloc = GetSemesterBloc(KaiRepository());
    getSemestrBloc..add(GetSemesterEventLoad());
    weekBloc = WeekBloc(MobileRepository())..add(WeekEventLoad());
    navigatorBloc = NavigatorBloc()..add(NavigatorEventSelectTab(selectTab: 0));
    loginBloc = LoginBloc(MobileRepository());
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    profileBloc = ProfileBloc(MobileRepository())
      ..add(ProfileEventInitialize());
    themeBloc.stream.listen((state) {
      print(state.toString());
    });

    profileBloc.stream.listen((state) {
      if (state is ProfileStateAuthorized) {
        print(state.toString());
      } else {
        print(state.toString());
      }
    });

    var newRoute = MaterialPageRoute(builder: (context) => _mainTabScreen());
    Future.delayed(Duration(seconds: 2),
        () => Navigator.pushReplacement(context, newRoute));
  }

  initFirebase() async {
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
      _firebaseMessaging.getToken().then((String token) async {
        print("fcm token $token");
        //await sendTokenToServer(token);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _mainTabScreen() {
    return MultiBlocProvider(providers: [
      BlocProvider<DayWeekBloc>.value(value: dayWeekBloc),
      BlocProvider<GetSemesterBloc>.value(value: getSemestrBloc),
      BlocProvider<WeekBloc>.value(value: weekBloc),
      BlocProvider<ProfileBloc>.value(value: profileBloc),
      BlocProvider<NavigatorBloc>.value(value: navigatorBloc),
      BlocProvider<LoginBloc>.value(value: loginBloc),
      BlocProvider<ThemeBloc>.value(value: themeBloc),
    ], child: MainTabScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xF9F9F9F9),
        child: SvgPicture.asset(
          'assets/Preview.svg',
          color: Color(0xFF1264af),
        ),
      ),
    );
  }
}

Future<void> sendTokenToServer(String token) async {
  var url = '/api/device';
  var uuid = UniqueKey().toString();
  var response = await http
      .post(url, body: {'uuid': uuid, 'token': token, 'platform': 'android'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
