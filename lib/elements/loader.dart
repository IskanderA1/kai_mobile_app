import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

Widget buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 100.0,
        width: 100.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Style.Colors.titleColor,
        ),
      )
    ],
  ));
}
