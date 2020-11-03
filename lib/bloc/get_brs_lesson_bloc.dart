import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetBRSLessonBloc{
  final KaiRepository repository = KaiRepository();
  final BehaviorSubject<List<LessonsBRSResponse>> _subject = BehaviorSubject<List<LessonsBRSResponse>>();

  getBrsLessons(int semesterNum) async{
    List<LessonsBRSResponse> response = List();
    for(int i = 1; i<=semesterNum;i++){
      response.add(await repository.getLessonsBRS(i));
    }
    _subject.sink.add(response);
  }
  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<LessonsBRSResponse>> get subject => _subject;

}
final getBRSLessonsBloc = GetBRSLessonBloc();