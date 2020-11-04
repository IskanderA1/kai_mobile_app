import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}
class _ExamsScreenState extends State<ExamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Style.Colors.titleColor,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Экзамены",
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        shadowColor: Colors.grey[100],
      ),
      body: Center(child: Text("Нет данных")),
    );
  }
}
