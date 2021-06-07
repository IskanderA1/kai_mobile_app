import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester/getsemester_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/bloc/theme/theme_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/user_model.dart';
import 'package:kai_mobile_app/style/constant.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ThemeBloc themeBloc;
  ProfileBloc profileBloc;
  GetSemesterBloc getSemesterBloc;
  int _semestersNum;

  @override
  void initState() {
    super.initState();
    themeBloc = context.read<ThemeBloc>();
    //BlocProvider.of<ThemeBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    getSemesterBloc = BlocProvider.of<GetSemesterBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSemesterBloc.stream.listen((state) {
      if (state is GetSemesterStateLoaded) {
        setState(() {
          _semestersNum = state.semesters.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          /*switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return buildLoadingWidget();
              break;
            case ConnectionState.none:
              return buildLoadingWidget();
              break;
            case ConnectionState.active:
              if (snapshot.data is UserResponseLoggedIn) {
                return _profileScreenBuilder(context, snapshot);
              } else {
                return buildLoadingWidget();
              }
              break;
            case ConnectionState.done:
              if (snapshot.data is UserResponseLoggedIn) {
                return _profileScreenBuilder(context, snapshot);
              } else {
                return buildLoadingWidget();
              }
              break;
            default:
              return buildLoadingWidget();
              break;
          }*/
          if (state is ProfileStateLoading) {
            return LoadingWidget();
          } else if (state is ProfileStateAuthorized) {
            return _profileScreenBuilder(context, state);
          } else if (state is ProfileStateError) {
            return Center(child: Text(state.error.toString()));
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Stack _profileScreenBuilder(
      BuildContext context, ProfileStateAuthorized state) {
    return Stack(children: [
      Column(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Image.asset(
                    'assets/placeholder.png',
                    width: MediaQuery.of(context).size.width,
                  ))),
          Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(top: 40, right: 30, left: 30),
                child: ListView(
                  children: [
                    _buildUserDataText(
                        label: "Институт:",
                        userData: state.user.instName,
                        icon: Icons.school),
                    _buildUserDataText(
                        label: "Специальность:",
                        userData: state.user.specName,
                        icon: Icons.menu_book),
                    _buildUserDataText(
                        label: "Номер группы:",
                        userData: state.user.groupNum,
                        icon: Icons.group),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sensor_door,
                          color: Colors.red,
                        ),
                        Text(
                          "Выйти",
                          style: kExitStyleText,
                        ),
                      ],
                    ),
                    onTap: () {
                      themeBloc.add(ThemeEventChangeTheme(ThemeItem.LIGHT));
                      profileBloc.add(ProfileEventLogout(
                          semesterNum:
                              (getSemesterBloc.state as GetSemesterStateLoaded)
                                  .semesters
                                  .length));
                    },
                  ),
                ),
              ))
        ],
      ),
      Positioned.fill(
        top: -150,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.80,
            child: _buildNameCard(state.user),
          ),
        ),
      ),
      Positioned.fill(
        top: 8,
        right: 16,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            //margin: EdgeInsets.only(left: 30, right: 30),
            height: 50,
            width: 50,
            child: _buildSwithcButton(),
          ),
        ),
      ),
    ]);
  }

  Widget _buildSwithcButton() {
    return DayNightSwitcher(
      isDarkModeEnabled: themeBloc.state is ThemeStateDark ? true : false,
      onStateChanged: (isDarkModeEnabled) {
        themeBloc.add(ThemeEventSwitch());
      },
    );
  }

  Widget _buildNameCard(UserModel user) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(children: [
          Flexible(
            child: AutoSizeText(
              user.studFio,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
              minFontSize: 10,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: AutoSizeText(
              "Номер зачетки: ${user.zach}",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              minFontSize: 6,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildUserDataText(
      {@required String label, @required String userData, IconData icon}) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: Row(
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: Theme.of(context).accentColor,
                  )
                : SizedBox(),
            SizedBox(
              width: 8,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      userData,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
