import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

final kHintTextStyle = TextStyle(
  color: Color(0xFFc5c8cf),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
final kProfileTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  //fontWeight: FontWeight.normal,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
final kAppBarTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
final kAppBarDisableTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);
final kAppBarEnableTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);

final kDataTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  //
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kExitStyleText = TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kSpanTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);
final kServiceMenuItemTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);

final kBoxImageBackgroundStyle = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kLeftButtonBottomRadius = BorderRadius.only(topLeft: Radius.circular(10));
final kRightButtonBottomRadius =
    BorderRadius.only(topRight: Radius.circular(10));
//Color(0xFF6CA8F1)
