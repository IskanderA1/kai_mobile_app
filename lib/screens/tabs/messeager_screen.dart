import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/bottom_navbar_bloc.dart';
class MessengerScreen extends StatefulWidget {
  @override
  _MessengerScreenState createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          child: Text(
              "Требуется\n авторизация",
            textAlign: TextAlign.center,
          ),
          onPressed: (){
            bottomNavBarBloc.pickItem(3);
          },
        ),
      ),
    );
  }
}
