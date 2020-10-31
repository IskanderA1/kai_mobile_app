import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/auth_user_bloc.dart';
class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Container(
        child: Center(
          child: Text("Новости"),
        ),
      ),
    );
  }
}
