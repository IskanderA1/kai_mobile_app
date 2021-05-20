import 'lesson_brs_model.dart';

class OneLessonBRSResponse {
  final List<LessonBRSModel> lessonsBRS;
  final String error;

  OneLessonBRSResponse(this.lessonsBRS, this.error);

  OneLessonBRSResponse.fromJson(Map<String, dynamic> json)
      : lessonsBRS = (json["Data"] as List)
            .map((i) => new LessonBRSModel.fromJson(i))
            .toList(),
        error = "";

  OneLessonBRSResponse.withError(String errorValue)
      : lessonsBRS = List.empty(),
        error = errorValue;
}

class OneLessonBRSResponseLoading extends OneLessonBRSResponse {
  OneLessonBRSResponseLoading() : super.withError("Загрузка");
}

class OneLessonBRSResponseOk extends OneLessonBRSResponse {
  OneLessonBRSResponseOk(Map<String, dynamic> json) : super.fromJson(json);
}

class OneLessonBRSResponseWithErrors extends OneLessonBRSResponse {
  OneLessonBRSResponseWithErrors(String err) : super.withError(err);
}

class LessonsBRSResponsesList {
  List<OneLessonBRSResponse> lessonsBRSResponsesList;
  String error;
  LessonsBRSResponsesList(this.lessonsBRSResponsesList) : error = "";

  add(Map<String, dynamic> json) {
    lessonsBRSResponsesList.addAll((json["Data"] as List)
        .map((i) => new OneLessonBRSResponse.fromJson(i))
        .toList());
    error = "";
  }

  LessonsBRSResponsesList.withError(this.error)
      : lessonsBRSResponsesList = null;

  LessonsBRSResponsesList.loading()
      : lessonsBRSResponsesList = null,
        error = "";
}

class LessonsBRSResponsesListOK extends LessonsBRSResponsesList {
  LessonsBRSResponsesListOK(
      /*List<OneLessonBRSResponse> lessonsBRSResponsesList*/)
      : super.withError("");
}

class LessonsBRSResponsesListLoading extends LessonsBRSResponsesList {
  LessonsBRSResponsesListLoading() : super.loading();
}

class LessonsBRSResponsesListWithErrors extends LessonsBRSResponsesList {
  LessonsBRSResponsesListWithErrors(String error) : super.withError(error);
}
