import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/theme/theme_bloc.dart';
import 'package:kai_mobile_app/model/lesson_model.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/screens/splash_screen.dart';
import 'package:kai_mobile_app/style/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'model/week_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';

/*// Crude counter to make messages unique
int _messageCount = 0;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WeekItemAdapter());
  Hive.registerAdapter(LessonModelAdapter());
  Hive.registerAdapter(LessonsResponseAdapter());
  Hive.openBox('lessons');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  /*await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);*/
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  FirebaseMessaging _firebaseMessanging = FirebaseMessaging();
  String token = await _firebaseMessanging.getToken();
  MobileRepository.sendDevice(token);
  _firebaseMessanging.onTokenRefresh.listen((event) {
    MobileRepository.sendDevice(event);
  });
  

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc themeBloc;
  @override
  void initState() {
    super.initState();
    themeBloc = ThemeBloc()..add(ThemeEventInitialize());
    themeBloc.listen((state) {
      print(state.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<ThemeBloc>.value(
      value: themeBloc,
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        if (state is ThemeStateLight) {
          return MaterialApp(
            title: 'KaiMobile',
            theme: themeLight,
            home: SplashScreen(),
          );
        } else {
          return MaterialApp(
            title: 'KaiMobile',
            theme: themeDark,
            home: SplashScreen(),
          );
        }
      }),
    );
  }
}

/*
/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}*/
