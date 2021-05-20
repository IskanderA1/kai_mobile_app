import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/day_bloc.dart';
import 'package:kai_mobile_app/bloc/day_week/dayweek_bloc.dart';
import 'package:kai_mobile_app/bloc/get_lessons_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/week/week_bloc.dart';
import 'package:kai_mobile_app/bloc/week_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/elements/loader_horisont.dart';
import 'package:kai_mobile_app/model/lesson_model.dart';
import 'package:kai_mobile_app/model/lessons_response.dart';

import '../../model/week_item.dart';

class LessonsScreen extends StatefulWidget {
  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  WeekBloc weekBloc;
  DayWeekBloc dayWeekBloc;

  @override
  void initState() {
    super.initState();
    weekBloc = context.read<WeekBloc>();
    getLessonsBloc..getLessons();
    dayWeekBloc = BlocProvider.of<DayWeekBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: dayWeekBloc.current.index,
      child: Column(
        children: [
          _buildWeekCheck(),
          Container(
            color: Theme.of(context).primaryColor,
            child: PreferredSize(
              preferredSize: null,
              child: TabBar(
                tabs: [
                  Tab(
                    text: "ПН",
                  ),
                  Tab(
                    text: "ВТ",
                  ),
                  Tab(
                    text: "СР",
                  ),
                  Tab(
                    text: "ЧТ",
                  ),
                  Tab(
                    text: "ПТ",
                  ),
                  Tab(
                    text: "СБ",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildLessonsView(1),
                _buildLessonsView(2),
                _buildLessonsView(3),
                _buildLessonsView(4),
                _buildLessonsView(5),
                _buildLessonsView(6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsView(int day) {
    return StreamBuilder(
        stream: getLessonsBloc.subject.stream,
        initialData: getLessonsBloc.defauiltItem,
        builder: (context, AsyncSnapshot<LessonsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is LessonsResponseUnAuth) {
              return AuthButton();
            } else if (snapshot.data is LessonsResponseError) {
              return Center(
                child: Text(snapshot.data.error),
              );
            } else if (snapshot.data is LessonsResponseLoading) {
              return LoadingWidget();
            } else if (snapshot.data is LessonsResponseOk) {
              return _buildLessonsList(snapshot.data, day);
            } else {
              return Container();
            }
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return LoadingWidget();
          }
        });
  }

  Widget _buildLessonsList(LessonsResponse lessonsResponse, int dayWeek) {
    List<LessonModel> lessons = lessonsResponse.lessons;
    return BlocBuilder(
        cubit: weekBloc,
        builder: (context, state) {
          print("state");
          if (state is WeekStateLoaded) {
            return ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return lessons[index].dayNum == dayWeek &&
                          (lessons[index].dayEven == state.week ||
                              lessons[index].dayEven == null)
                      ? _buildLessonItem(lessons[index])
                      : Container();
                });
          } else {
            return LoadingWidget();
          }
        });
  }

  Widget _buildWeekCheck() {
    return BlocBuilder<WeekBloc, WeekState>(
        builder: (context, state) {
          if (state is WeekStateLoaded) {
            return Container(
              color: Theme.of(context).primaryColor,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      weekBloc.add(WeekEventPick(week: WeekItem.EVEN));
                    },
                    child: Container(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Четная",
                            style: state.week == WeekItem.EVEN
                                ? Theme.of(context).textTheme.headline3
                                : Theme.of(context).textTheme.headline4,
                          )),
                    ),
                  )),
                  SizedBox(
                    height: 25,
                    width: 1,
                    child: Container(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      weekBloc.add(WeekEventPick(week: WeekItem.UNEVEN));
                    },
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Нечетная",
                          style: state.week == WeekItem.UNEVEN
                              ? Theme.of(context).textTheme.headline3
                              : Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            );
          }
          if (state is WeekStateLoading) {
            return LoadingHorisontalWidget();
          }
          return Container();
        });
  }

  Widget _buildLessonItem(LessonModel lesson) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Container(
        height: 110,
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          lesson.dayTime,
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          "Здание: ${lesson.buildNum}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Ауд: ${lesson.audNum}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: AutoSizeText(
                            "${lesson.disciplineName}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                            minFontSize: 8,
                            maxFontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Flexible(
                          flex: 1,
                          child: AutoSizeText(
                            "${lesson.disciplineType}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 6,
                            maxFontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Flexible(
                          flex: 1,
                          child: AutoSizeText(
                            "${lesson.prepodName}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            minFontSize: 6,
                            maxFontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Flexible(
                          flex: 1,
                          child: lesson.dayDate != null
                              ? AutoSizeText(
                                  "${lesson.dayDate}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  minFontSize: 6,
                                  maxFontSize: 14,
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
