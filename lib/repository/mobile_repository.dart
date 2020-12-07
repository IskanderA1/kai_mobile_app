import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/activitys_response.dart';
import 'package:kai_mobile_app/model/news_response.dart';
import 'package:kai_mobile_app/model/report_response.dart';
import 'package:kai_mobile_app/model/reports_response.dart';

class MobileRepository {
  static String mainUrl = "http://kaimobile.loliallen.com/";
  static String newsUrl = "api/posts/";
  static String reportsUrl = "api/reports/";
  static String activitiesUrl = "api/activities/";
  static String sendReportUrl = "api/reports/";
  static String getDateUrl = "api/date/";
  //Временный токен
  static String userToken =
      "oNdqgXvuPkiHfAEhRhMLJkEQUS3ikuSuZCbhIyz4eNkwnwEia3UudTzjzzPwngffjU4CHDr1X7Ad6gSauhAC4cQ26EglUwgNj6pKBzjkCkZ9JTlK7d5k5XG127T5QJpmU6IjBpftEwxDKC9Ha4ZrfQwQ3leBRZETWDMY20XoDOEqCqIKPVPVeDtEGcgZvAxZ7juYMFTeuT8bxP3vLtJcKTn6QBYNqmnS22ipjsPtHfmx44yKkkKTcKlTxREsUkDT";

  final Dio _dio = Dio();

  Future<NewsResponse> getNews() async {
    var headers = {"Authorization": "Bearer $userToken"};
    try {
      Response response = await _dio.get(mainUrl + newsUrl,
          options: Options(
            headers: headers,
          ));
      //var data = jsonDecode(response.data);

      var rest = response.data as List;
      //print(rest);
      if (rest.isNotEmpty) {
        return NewsResponse.fromJson(response.data);
      } else {
        return NewsResponse.withError("Нет новостей");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return NewsResponse.withError("Нет сети");
    }
  }

  Future<ReportsResponse> getReports() async {
    var headers = {"Authorization": "Bearer $userToken"};
    try {
      Response response = await _dio.get(mainUrl + reportsUrl,
          options: Options(
            headers: headers,
          ));
      //var data = jsonDecode(response.data);

      var rest = response.data as List;
      print(rest);
      if (rest.isNotEmpty) {
        return ReportsResponse.fromJson(response.data);
      } else {
        return ReportsResponse.withError("Нет заявок");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ReportsResponse.withError("Нет сети");
    }
  }

  Future<ActivitysResponse> getActivitys() async {
    var headers = {"Authorization": "Bearer $userToken"};
    try {
      Response response = await _dio.get(mainUrl + activitiesUrl,
          options: Options(
            headers: headers,
          ));
      //var data = jsonDecode(response.data);

      var rest = response.data as List;
      //print(rest);
      if (rest.isNotEmpty) {
        return ActivitysResponse.fromJson(response.data);
      } else {
        return ActivitysResponse.withError("Нет Активностей");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ActivitysResponse.withError("Нет сети");
    }
  }

  Future<ReportResponse> sendReport(File file, String text) async {
    var headers = {"Authorization": "Bearer $userToken"};

    if (text.isNotEmpty && file != null) {
      try {
        String fileName = file.path.split('/').last;
        FormData formData = FormData.fromMap({
          "message": "$text",
          "image": await MultipartFile.fromFile(file.path, filename: fileName),
        });
        Response response = await _dio.post(mainUrl + sendReportUrl,
            data: formData,
            options: Options(
              headers: headers,
            ));
        print(response);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          print("Ваша заявка принята");
          return ReportResponse.responseText("Ваша заявка принята");
        } else if ((response.statusCode >= 500)) {
          return ReportResponse.responseText("Ошибка сервера");
        } else {
          return ReportResponse.responseText("Ошибка ");
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return ReportResponse.responseText("Не удалось отправить запрос");
      }
    } else {
      return ReportResponse.responseText("Заполните все поля");
    }
  }

  Future<int> getCurrWeek() async {
    var headers = {"Authorization": "Bearer $userToken"};
    try {
      Response response = await _dio.get(mainUrl + getDateUrl,
          options: Options(
            headers: headers,
          ));
      print(response.data["eod"]);
      return (response.data["eod"]);
    } catch (error) {
      return 0;
    }
  }
}
