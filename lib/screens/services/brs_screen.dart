import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/get_brs_lesson_bloc.dart';
import 'package:kai_mobile_app/bloc/get_brs_one_lesson_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester/getsemester_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/lesson_brs_model.dart';
import 'package:kai_mobile_app/model/lesson_brs_response.dart';
import 'package:kai_mobile_app/model/semester_brs_model.dart';

class BRSScreen extends StatefulWidget {
  @override
  _BRSScreenState createState() => _BRSScreenState();
}

class _BRSScreenState extends State<BRSScreen> with TickerProviderStateMixin {
  GetSemesterBloc getSemesterBloc;

  @override
  void initState() {
    super.initState();
    getSemesterBloc = BlocProvider.of<GetSemesterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSemesterBloc, GetSemesterState>(
        buildWhen: (prev, news) {
      return prev != news;
    }, builder: (context, state) {
      if (state is GetSemesterStateLoading) {
        return LoadingWidget();
      } else if (state is GetSemesterStateError) {
        return Center(child: Text(state.error.toString()));
      } else if (state is GetSemesterStateLoaded) {
        return FutureBuilder(
            future: getBrsLessons(state.semesters.length),
            builder: (BuildContext context, AsyncSnapshot<String> snap) {
              if (snap.hasData) {
                return DefaultTabController(
                  length: state.semesters.length,
                  initialIndex: state.semesters.length - 1,
                  child: Scaffold(
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
                        "БРС",
                      ),
                      centerTitle: true,
                      bottom: TabBar(
                        labelColor: Theme.of(context).accentColor,
                        tabs: state.semesters.map((SemestrModel semester) {
                          return Tab(
                            text: semester.semesterNum.toString(),
                          );
                        }).toList(),
                      ),
                    ),
                    body: TabBarView(
                      children: state.semesters.map((SemestrModel semester) {
                        return Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, right: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Предмет",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Аттестация",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Итог",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: Container(
                                  child: _buildBRSView(
                                      getBRSLessonsBloc.semestersBlocs[
                                          semester.semesterNum - 1])),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              } else {
                return LoadingWidget();
              }
            });
      }
    });
  }
  
  /*Future<SemesterResponse> getSemesters() async {
    SemesterResponse resp = await getSemestrBloc.getSemestr();
    return resp;
  }*/

  Future<String> getBrsLessons(int count) async {
    getBRSLessonsBloc.getBrsLessons(count);
    return "Ok";
  }

  Widget _buildBRSView(GetBRSOneLessonBloc semesterStream) {
    return StreamBuilder(
        stream: semesterStream.subject.stream,
        builder: (context, AsyncSnapshot<OneLessonBRSResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is OneLessonBRSResponseLoading) {
              return LoadingWidget();
            } else if (snapshot.data is OneLessonBRSResponseOk) {
              return _buildBRSList(snapshot.data
                  /*snapshot
                  .data.lessonsBRSResponsesList[semsetrNum - 1].lessonsBRS*/
                  );
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

  _buildBRSList(OneLessonBRSResponse brsList) {
    return ListView.separated(
        separatorBuilder: (ctx, index) => Divider(color: Colors.black),
        itemCount: brsList.lessonsBRS.length,
        itemBuilder: (context, index) {
          return _buildBRSItem(brsList.lessonsBRS[index]);
          //Text(brsList[index].disciplineName);
        });
  }

  Widget _buildBRSItem(LessonBRSModel lessonBRSModel) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 8),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  lessonBRSModel.disciplineName,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 14,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att1.toString(),
                            style: TextStyle(),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt1}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att2.toString(),
                            style: TextStyle(),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt2}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessonBRSModel.att3.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "из ${lessonBRSModel.maxAtt3}",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Text(
                "${lessonBRSModel.finBall > 0 ? lessonBRSModel.finBall : lessonBRSModel.att1 + lessonBRSModel.att2 + lessonBRSModel.att3}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: lessonBRSModel.finBall > 50
                      ? Colors.lightGreen
                      : Theme.of(context).disabledColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
