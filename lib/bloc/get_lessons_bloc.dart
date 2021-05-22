import 'package:kai_mobile_app/model/lesson_model.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetLessonsBloc {
  final KaiRepository _repository = KaiRepository();
  final BehaviorSubject<LessonsResponse> _subject =
  BehaviorSubject<LessonsResponse>();

  LessonsResponse get defauiltItem => LessonsResponse(List<LessonModel>.empty(), "");

  getLessons() async {
    _subject.sink.add(LessonsResponseLoading());
    _repository.getLessons().then((value) => _subject.sink.add(value));
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LessonsResponse> get subject => _subject;

}
final getLessonsBloc = GetLessonsBloc();