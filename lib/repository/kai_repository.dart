


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaiRepository{
  static String mainUrl = "http://app.kai.ru/api";
  final Dio _dio = Dio();

  Future<UserResponse> userAuth(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "authToken": "{token}",
      "runParams" : "{\"PipelineId\":270701192,"
          "\"StepId\":10,"
          "\"OutputName\":\"Row\","
          "\"Variables\":{"
          "\"Login\":\"$login\","
          "\"Password\":\"$password\"}"
          "}",
      };
    try {
      Response response = await _dio.get(mainUrl, queryParameters: params);
      var data = jsonDecode(response.data);
      var rest = data["Data"] as List;
      print(data);
      if(rest.isNotEmpty){
        prefs.setString("login", login);
        prefs.setString("password", password);
        prefs.setString("userData", jsonEncode(data["Data"][0]));
        print(jsonEncode(data["Data"][0]));
        return UserResponse.fromJson(data["Data"][0]);
      }else{
        print("Неверный логин или пароль");
        return UserResponse.withError("Неверный логин или пароль");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("Нет сети");
    }
  }

  Future<UserResponse> userAuthLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("login");
    String password = prefs.getString("password");
    var dataSP = prefs.getString("userData") != null?jsonDecode(prefs.getString("userData")):null;
    if(login !=null && password !=null &&dataSP!=null){
      var params = {
        "authToken": "{token}",
        "runParams" : "{\"PipelineId\":270701192,"
            "\"StepId\":10,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"Login\":\"$login\","
            "\"Password\":\"$password\"}"
            "}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data);
        var rest = data["Data"] as List;
        print(data);
        if(rest.isNotEmpty){
          prefs.setString("userData", jsonEncode(data["Data"][0]));
          return UserResponse.fromJson(data["Data"][0]);
        }else{
          print("Авторизуйтесь");
          return UserResponse.withError("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        //print("Exception occured: $error stackTrace: $stacktrace");
        return UserResponse.fromJson(dataSP);
      }
    }else{
      return UserResponse.withError("Авторизуйтесь");
    }
  }

  Future<UserResponse> userLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    prefs.remove("password");
    prefs.remove("userData");
    return UserResponse.withError("Авторизуйтесь");
  }
}