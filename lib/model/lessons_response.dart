import 'package:hive/hive.dart';
import 'package:kai_mobile_app/model/lesson_model.dart';
part 'lessons_response.g.dart';

@HiveType(typeId: 2)
class LessonsResponse {
  @HiveField(0)
  final List<LessonModel> lessons;
  @HiveField(1)
  final String error;

  LessonsResponse(this.lessons, this.error);

  LessonsResponse.fromJson(Map<String, dynamic> json)
      : lessons = (json["Data"] as List)
            .map((i) => new LessonModel.fromJson(i))
            .toList(),
        error = "";

  LessonsResponse.withError(String errorValue)
      : lessons = List.empty(),
        error = errorValue;
}

class LessonsResponseLoading extends LessonsResponse{
  LessonsResponseLoading():super.withError("");
}

class LessonsResponseOk extends LessonsResponse{
  LessonsResponseOk(Map<String, dynamic> json):super.fromJson(json);
  LessonsResponseOk.fromList(List<LessonModel> lessons):super(lessons, "");
}

class LessonsResponseError extends LessonsResponse{
  LessonsResponseError(String err):super.withError(err);
}

class LessonsResponseUnAuth extends LessonsResponse{
  LessonsResponseUnAuth():super.withError("Авторизуйтесь");
}