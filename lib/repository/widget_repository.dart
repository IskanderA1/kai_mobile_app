import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/model/weather_response.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

const apiKeyWeather = '2e443cf7753349b195378473e6668eaf';
const cityName = 'Kazan';

class WidgetRepository {
  static String weatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKeyWeather&units=metric";
  static String firebaseUrl = 'https://e0cf7973d18e.ngrok.io/api/device/new';

  final Dio _dio = Dio();

  Future<WeatherResponse> getWeather() async {
    try {
      Response response = await _dio.post(weatherUrl);
      var data = response.data;
      print(data);
      var rest = data["weather"] as List;
      if (rest.isNotEmpty) {
        print(jsonEncode(data));
        return WeatherResponse.fromJson(data);
      } else {
        return WeatherResponse.withError("Нет данных");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return WeatherResponse.withError("Нет сети");
    }
  }

  Future<void> getFCMtoken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    try {
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

    
  }

  Future<void> sendTokenToServer(String token) async {
    var uuid = UniqueKey().toString();
    var response = await http.post(firebaseUrl,
        body: {'uuid': uuid, 'token': token, 'platform': 'android'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
