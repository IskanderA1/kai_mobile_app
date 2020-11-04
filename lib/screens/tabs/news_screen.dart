import 'package:flutter/material.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;
import 'package:kai_mobile_app/bloc/news_type_bloc.dart';
class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Column(
        children: [
          _buildWeekCheck(),
          Expanded(child: Center(child: Text("Нет данных"),))
        ],
      ),

    );
  }

  Widget _buildWeekCheck() {
    return StreamBuilder(
        stream: newsTypeBloc.newsTypeStream,
        initialData: newsTypeBloc.defNewsType,
        builder: (context, AsyncSnapshot<NewsTypeItem> snapshot) {
          return Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: () {
                        newsTypeBloc.pickWeek(0);
                      },
                      child: Container(
                        color: Style.Colors.mainColor,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Новости КАИ",
                            style: snapshot.data == NewsTypeItem.KAI
                                ? kAppBarEnableTextStyle
                                : kAppBarDisableTextStyle,
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 25,
                  width: 1,
                  child: Container(
                    color: Style.Colors.titleColor,
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: () {
                        newsTypeBloc.pickWeek(1);
                      },
                      child: Container(
                        color: Style.Colors.mainColor,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Факультета",
                            style: snapshot.data == NewsTypeItem.FAC
                                ? kAppBarEnableTextStyle
                                : kAppBarDisableTextStyle,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
