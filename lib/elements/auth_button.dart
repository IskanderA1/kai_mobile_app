import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/bottom_navbar_bloc.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

Widget buildAuthButton(){
  return Center(
    child: FlatButton(
      child: Text(
        "Авторизоваться",
            style: TextStyle(
          color: Colors.white
      ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Style.Colors.titleColor,
      onPressed: (){
        bottomNavBarBloc..pickItem(3);
      },
    ),
  );
}