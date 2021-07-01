import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kai_mobile_app/model/exams_response.dart';
import 'package:kai_mobile_app/model/group_mate_respose.dart';
import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';
import 'package:kai_mobile_app/model/semester_brs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/lessons_response.dart';

class KaiRepository {
  static String mainUrl = "https://app.kai.ru/api";
  final Dio _dio = Dio();

  // Future<UserResponse> userAuth(String login, String password) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var params = {
  //     "authToken": "{token}",
  //     "runParams": "{\"PipelineId\":270701192,"
  //         "\"StepId\":10,"
  //         "\"OutputName\":\"Row\","
  //         "\"Variables\":{"
  //         "\"Login\":\"$login\","
  //         "\"Password\":\"$password\"}"
  //         "}",
  //   };
  //   try {
  //     Response response = await _dio.get(mainUrl, queryParameters: params);
  //     var data = jsonDecode(response.data);
  //     var rest = data["Data"] as List;
  //     //print(data);
  //     if (rest.isNotEmpty) {
  //       prefs.setString("login", login);
  //       prefs.setString("password", password);
  //       prefs.setString("userData", jsonEncode(data["Data"][0]));
  //       print(jsonEncode(data["Data"][0]));
  //       return UserResponse.fromJson(data["Data"][0]);
  //     } else {
  //       print("Неверный логин или пароль");
  //       return UserResponse.withError("Неверный логин или пароль");
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return UserResponse.withError("Нет сети");
  //   }
  // }

  // Future<UserResponse> userAuthLocal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String login = prefs.getString("login");
  //   String password = prefs.getString("password");
  //   var dataSP = prefs.getString("userData") != null ? jsonDecode(
  //       prefs.getString("userData")) : null;
  //   if (login != null && password != null && dataSP != null) {
  //     var params = {
  //       "authToken": "{token}",
  //       "runParams": "{\"PipelineId\":270701192,"
  //           "\"StepId\":10,"
  //           "\"OutputName\":\"Row\","
  //           "\"Variables\":{"
  //           "\"Login\":\"$login\","
  //           "\"Password\":\"$password\"}"
  //           "}",
  //     };
  //     try {
  //       Response response = await _dio.get(mainUrl, queryParameters: params);
  //       var data = jsonDecode(response.data);
  //       var rest = data["Data"] as List;
  //       //print(data);
  //       if (rest.isNotEmpty) {
  //         prefs.setString("userData", jsonEncode(data["Data"][0]));
  //         return UserResponse.fromJson(data["Data"][0]);
  //       } else {
  //         print("Авторизуйтесь");
  //         return UserResponse.withError("Авторизуйтесь");
  //       }
  //     } catch (error) {
  //       //print("Exception occured: $error stackTrace: $stacktrace");
  //       return UserResponse.fromJson(dataSP);
  //     }
  //   } else {
  //     return UserResponse.withError("Авторизуйтесь");
  //   }
  // }

  // Future<UserResponse> userLogOut(int semestrNum) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for(int i = 1;i<semestrNum;i++){
  //     prefs.remove("brs$i");
  //   }
  //   prefs.remove("login");
  //   prefs.remove("password");
  //   prefs.remove("userData");
  //   prefs.remove("examssData");
  //   prefs.remove("lessonsData");
  //   prefs.remove("semestr");
  //   prefs.remove("group");
  //   prefs.remove("userTheme");
  //   return UserResponse.withError("Авторизуйтесь");
  // }

  Future<LessonsResponse> getLessons() async {
    Hive.openBox("lessons");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsSP = prefs.getString("lessonsData") != null
        ? jsonDecode(prefs.getString("lessonsData"))
        : null;
    if (dataSP != null) {
      LessonsResponse lResp =
          Hive.box('lessons').get('lessons', defaultValue: null);
      if (lResp != null) {
        DateTime whenUpdated = Hive.box('lessons').get('lastUpdate');
        DateTime now = DateTime.now();
        int duration = now.difference(whenUpdated).inHours;
        if (duration < 24) {
          return LessonsResponseOk.fromList(lResp.lessons);
        }
      }

      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145877938,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response resp = await _dio.request(mainUrl, queryParameters: params);
        print(resp.request.baseUrl);
        Response response = await _dio.get(mainUrl, queryParameters: params);

        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          LessonsResponse lessons = LessonsResponse.fromJson(data);
          Hive.box('lessons').put('lessons', lessons);
          Hive.box('lessons').put('lastUpdate', DateTime.now());
          return LessonsResponseOk.fromList(lessons.lessons);
        } else {
          return LessonsResponseError("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsSP != null) {
          return LessonsResponseOk(lessonsSP);
        }
        return LessonsResponseError("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return LessonsResponseUnAuth();
    }
  }

  Future<ExamsResponse> getExams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsSP = prefs.getString("examssData") != null
        ? jsonDecode(prefs.getString("examssData"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145877940,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);

        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("examssData", jsonEncode(data));
          return ExamsResponseOk(data);
        } else {
          return ExamsResponseEmpty();
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsSP != null) {
          return ExamsResponseOk(lessonsSP);
        }
        return ExamsResponseUserUnAuth("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return ExamsResponseUserUnAuth("Авторизуйтесь");
    }
  }

  Future<List<SemestrModel>> getSemestr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('getSemestr');
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var semestrSP = prefs.getString("semestr") != null
        ? jsonDecode(prefs.getString("semestr"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145864128,"
            "\"StepId\":3,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);

        var data = jsonDecode(response.data);
        var rest = data["Data"] as List;
        print("rest = $rest");

        if (rest.isNotEmpty) {
          print("${data["Data"][0]} Кол-во семестров");
          prefs.setString("semestr", jsonEncode(data["Data"][0]));
          return List<SemestrModel>.from((data["Data"])
              .map((e) => SemestrModel.fromJson(e))
              .toList());
        } else {
          throw Exception("Свервер вернул пустой список данных");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (semestrSP != null) {
          return List<SemestrModel>.from(
              (semestrSP).map((e) => SemestrModel.fromJson(e)).toList());
        }
        throw Exception(error);
      }
    } else {
      print("Требуется авторизация");
      throw Exception("Требуется авторизация");
    }
  }

  Future<OneLessonBRSResponse> getOneSemesterLessonsBRS(int semesterNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var lessonsBRSSP = prefs.getString("brs$semesterNum") != null
        ? jsonDecode(prefs.getString("brs$semesterNum"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":445063016,"
            "\"StepId\":11,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\",\"Semestr\":\"$semesterNum\""
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data);
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("BRS: ${data["Data"][0]}");
          prefs.setString("brs$semesterNum", jsonEncode(data));
          return OneLessonBRSResponseOk(data);
        } else {
          return OneLessonBRSResponseWithErrors("Авторизуйтесь");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (lessonsBRSSP != null) {
          return OneLessonBRSResponseOk(lessonsBRSSP);
        }
        return OneLessonBRSResponseWithErrors("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return OneLessonBRSResponseWithErrors("Авторизуйтесь");
    }
  }

  Future<GroupMateResponse> getGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dataSP = prefs.getString("userData") != null
        ? jsonDecode(prefs.getString("userData"))
        : null;
    var groupSP = prefs.getString("group") != null
        ? jsonDecode(prefs.getString("group"))
        : null;
    if (dataSP != null) {
      print("${dataSP["stud_id"]}");
      var params = {
        "authToken": "{token}",
        "runParams": "{\"PipelineId\":145873539,"
            "\"StepId\":6,"
            "\"OutputName\":\"Row\","
            "\"Variables\":{"
            "\"StudId\":\"${dataSP["stud_id"]}\","
            "}}",
      };
      try {
        Response response = await _dio.get(mainUrl, queryParameters: params);
        var data = jsonDecode(response.data.replaceAll(RegExp(r"\\"), "/"));
        var rest = data["Data"] as List;
        if (rest.isNotEmpty) {
          print("${data["Data"][0]} test");
          prefs.setString("group", jsonEncode(data));
          return GroupMateResponse.fromJson(data);
        } else {
          return GroupMateResponse.withError("Нет данных");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        if (groupSP != null) {
          return GroupMateResponse.fromJson(groupSP);
        }
        return GroupMateResponse.withError("Авторизуйтесь");
      }
    } else {
      print("Требуется авторизация");
      return GroupMateResponse.withError("Авторизуйтесь");
    }
  }
}
