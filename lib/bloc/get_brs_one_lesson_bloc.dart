import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetBRSOneLessonBloc {
  final KaiRepository repository = KaiRepository();
  final BehaviorSubject<OneLessonBRSResponse> _subject =
      BehaviorSubject<OneLessonBRSResponse>();
  final int semesterNumber;
  GetBRSOneLessonBloc({this.semesterNumber});

  getBrsLessons() async {
    _subject.sink.add(OneLessonBRSResponseLoading());
    OneLessonBRSResponse lResponse;
    lResponse = await repository.getOneSemesterLessonsBRS(semesterNumber);
    _subject.sink.add(lResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<OneLessonBRSResponse> get subject => _subject;
}
