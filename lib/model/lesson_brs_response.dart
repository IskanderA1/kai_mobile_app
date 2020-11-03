

import 'lesson_brs_model.dart';

class LessonsBRSResponse {
  final List<LessonBRSModel> lessonsBRS;
  final String error;

  LessonsBRSResponse(this.lessonsBRS, this.error);

  LessonsBRSResponse.fromJson(Map<String, dynamic> json)
      : lessonsBRS =
  (json["Data"] as List).map((i) => new LessonBRSModel.fromJson(i)).toList(),
        error = "";

  LessonsBRSResponse.withError(String errorValue)
      : lessonsBRS = List(),
        error = errorValue;
}