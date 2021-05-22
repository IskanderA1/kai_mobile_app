import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingHorisontalWidget extends StatelessWidget {
  const LoadingHorisontalWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.0,
          width: 50.0,
          child: SpinKitThreeBounce(
            size: 25,
            color: Color(0xFF3985c0),
          ),
        )
      ],
    ));
  }
}
