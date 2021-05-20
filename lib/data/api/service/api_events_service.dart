import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kai_mobile_app/model/application_model.dart';
import 'package:kai_mobile_app/model/member_model.dart';
import 'package:kai_mobile_app/model/rating_list_models.dart';

import '../../../model/event_model.dart';

class ApiEventsService {
  static const _BASE_URL = 'https://mobile.kai.ru';
  static final _singleton = ApiEventsService._();
  static final _dio = Dio(BaseOptions(baseUrl: _BASE_URL));

  factory ApiEventsService() {
    return _singleton;
  }

  ApiEventsService._();

  Future<List<Event>> getEventsList(String token) async {
    Response response;
    try {
      response = await _dio.get('/api/events',
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      var events;
      try {
        events = List<Event>.from(response.data.map((e) => Event.fromMap(e)));
      } catch (e) {
        return List<Event>.empty();
      }
      if (events == null) {
        return List<Event>.empty();
      }
      return events;
    } else {
      return List<Event>.empty();
    }
  }

  Future<bool> createApplication(String token, String eventId, String comment,
      String memberId, File file) async {
    Response response;
    String filename;
    FormData data;
    if (file == null) {
      data = FormData.fromMap({
        'event': eventId,
        'comment': comment,
        'member_id': memberId,
      });
    } else {
      filename = file.path.split('/').last;
      data = FormData.fromMap({
        'event': eventId,
        'comment': comment,
        'member_id': memberId,
        'image': MultipartFile.fromFile(file.path, filename: filename),
      });
    }
    try {
      response = await _dio.post('/api/application',
          data: data,
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Application>> getApplications(String token) async {
    Response response;
    try {
      response = await _dio.get('/api/application',
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      var apps;
      try {
        apps = List<Application>.from(
            response.data.map((e) => Application.fromMap(e)));
      } catch (e) {
        return List<Application>.empty();
      }
      if (apps == null) {
        return List<Application>.empty();
      }
      return apps;
    } else {
      return List<Application>.empty();
    }
  }

  Future<List<RatingElements>> getRating(String token) async {
    Response response;
    try {
      response = await _dio.get('/api/portfolio/leaderboard',
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      var rates;
      try {
        rates = List<RatingElements>.from(
            response.data.map((e) => RatingElements.fromMap(e)));
      } catch (e) {
        return List<RatingElements>.empty();
      }
      if (rates == null) {
        return List<RatingElements>.empty();
      }
      return rates;
    } else {
      return List<RatingElements>.empty();
    }
  }

  Future<List<Member>> getMembersList(String token) async {
    Response response;
    try {
      response = await _dio.get('/api/members',
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      var members;
      try {
        members =
            List<Member>.from(response.data.map((e) => Member.fromMap(e)));
      } catch (e) {
        return List<Member>.empty();
      }
      if (members == null) {
        return List<Member>.empty();
      }
      return members;
    } else {
      return List<Member>.empty();
    }
  }

  Future<bool> createPortfolio(String token) async {
    Response response;
    try {
      response = await _dio.post('/api/portfolio',
          data: {},
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> offerApplication(String token, Map<String, String> map) async {
    Response response;
    try {
      response = await _dio.post('/api/portfolio',
          data: FormData.fromMap(map),
          options: Options(headers: {"Authorization": "Token $token"}));
    } on DioError {
      throw Exception('Упс, что-то пошло не так...');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
