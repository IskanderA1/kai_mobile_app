import 'package:kai_mobile_app/bloc/get_brs_one_lesson_bloc.dart';
import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetBRSLessonBloc {
  final KaiRepository repository = KaiRepository();
  final BehaviorSubject<LessonsBRSResponsesList> _subject =
      BehaviorSubject<LessonsBRSResponsesList>();

  List<GetBRSOneLessonBloc> semestersBlocs;

  List<GetBRSOneLessonBloc> get semesters => semestersBlocs;

  Future getBrsLessons(int semesterCount) async {
    semestersBlocs = List<GetBRSOneLessonBloc>();
    _subject.sink.add(LessonsBRSResponsesListLoading());
    for (int i = 1, k = 0; i <= semesterCount || k < semesterCount; i++, k++) {
      semestersBlocs.add(GetBRSOneLessonBloc(semesterNumber: i));
      //semestersBlocs[k].getBrsLessons();
    }
    for (int i = semesterCount - 1; i >= 0; i--) {
      //semestersBlocs.add(GetBRSOneLessonBloc(semesterNumber: i));
      await semestersBlocs[i].getBrsLessons();
    }
    _subject.sink.add(LessonsBRSResponsesListOK());
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LessonsBRSResponsesList> get subject => _subject;
}

final getBRSLessonsBloc = GetBRSLessonBloc();
