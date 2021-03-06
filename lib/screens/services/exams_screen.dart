import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/get_exams_bloc.dart';

import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/week/week_bloc.dart';
import 'package:kai_mobile_app/bloc/week_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/exam_model.dart';
import 'package:kai_mobile_app/model/exams_response.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  WeekBloc weekBloc;
  @override
  void initState() {
    super.initState();
    getExamsBloc..getExams();
    weekBloc = BlocProvider.of<WeekBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Экзамены",
        ),
        centerTitle: true,
      ),
      body: _buildExamsView(),
    );
  }

  Widget _buildExamsView() {
    return StreamBuilder(
        stream: getExamsBloc.subject.stream,
        builder: (context, AsyncSnapshot<ExamsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ExamsResponseUserUnAuth) {
              return AuthButton();
            } else if (snapshot.data is ExamsResponseEmpty) {
              return Center(
                child: Text("Список экзаменов пуст"),
              );
            } else if (snapshot.data is ExamsResponseOk) {
              return _buildLessonsList(snapshot.data);
            } else if (snapshot.data is ExamsResponseWithError) {
              return Center(
                child: Text(snapshot.data.error),
              );
            }
            return LoadingWidget();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return LoadingWidget();
          }
        });
  }

  Widget _buildLessonsList(ExamsResponse lessonsResponse) {
    List<ExamModel> lessons = lessonsResponse.exams;
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return _buildLessonItem(lessons[index]);
        });
  }

  Widget _buildLessonItem(ExamModel examModel) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Card(
        child: Container(
          height: 110,
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
                          examModel.examTime,
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          "Здание: ${examModel.buildNum}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Ауд: ${examModel.audNum}",
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
                        Text(
                          examModel.disciplineName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${examModel.prepodName}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${examModel.examDate}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Theme.of(context).accentColor,
                          ),
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
