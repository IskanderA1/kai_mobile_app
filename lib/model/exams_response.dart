import 'package:kai_mobile_app/model/exam_model.dart';

class ExamsResponse {
  final List<ExamModel> exams;
  final String error;

  ExamsResponse(this.exams, this.error);

  ExamsResponse.fromJson(Map<String, dynamic> json)
      : exams = (json["Data"] as List)
            .map((i) => new ExamModel.fromJson(i))
            .toList(),
        error = "";

  ExamsResponse.withError(String errorValue)
      : exams = List(),
        error = errorValue;
}

class ExamsResponseLoading extends ExamsResponse {
  ExamsResponseLoading() : super.withError("");
}

class ExamsResponseWithError extends ExamsResponse {
  ExamsResponseWithError(String err) : super.withError(err);
}

class ExamsResponseEmpty extends ExamsResponse {
  ExamsResponseEmpty() : super.withError("");
}

class ExamsResponseUserUnAuth extends ExamsResponse {
  ExamsResponseUserUnAuth(String err) : super.withError(err);
}

class ExamsResponseOk extends ExamsResponse {
  ExamsResponseOk(var data) : super.fromJson(data);
}
