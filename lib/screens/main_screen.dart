import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/screens/main_tabs_screen.dart';
import 'package:kai_mobile_app/screens/util/auth_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, state) {
        if (state is ProfileStateAuthorized) {
          return MainTabScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
