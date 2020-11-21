
import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/activitys_response.dart';
import 'package:kai_mobile_app/model/news_response.dart';

class MobileRepository {
  static String mainUrl = "http://kaimobile.loliallen.com/";
  static String newsUrl = "api/posts/";
  static String activitiesUrl = "api/activities/";
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
      print(rest);
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

   Future<ActivitysResponse> getActivitys() async {
    var headers = {"Authorization": "Bearer $userToken"};
    try {
      Response response = await _dio.get(mainUrl + activitiesUrl,
          options: Options(
            headers: headers,
          ));
      //var data = jsonDecode(response.data);
      
      var rest = response.data as List;
      print(rest);
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

}
