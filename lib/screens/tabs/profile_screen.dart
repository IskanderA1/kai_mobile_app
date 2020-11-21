import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/auth_user_bloc.dart';
import 'package:kai_mobile_app/bloc/get_semester_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: StreamBuilder<UserResponse>(
        stream: authBloc.subject.stream,
        builder: (context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.data != null) {
            return Stack(children: [
              Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        decoration: kBoxImageBackgroundStyle,
                      )),
                  Expanded(
                      flex: 8,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, right: 30, left: 30),
                        child: Column(
                          children: [
                            _buildUserDataText(
                                label: "Инстиут:",
                                userData: snapshot.data.user.instName,
                                icon: Icons.school),
                            _buildUserDataText(
                                label: "Специальность:",
                                userData: snapshot.data.user.specName,
                                icon: Icons.menu_book),
                            _buildUserDataText(
                                label: "Номер группы:",
                                userData: snapshot.data.user.groupNum,
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
                          authBloc..authLogOut(getSemestrBloc.subject.value.semesters.length!=null?getSemestrBloc.subject.value.semesters.length:0);
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
                    height: 100,
                    width: 370,
                    decoration: kBoxImageBackgroundStyle,
                    child: _buildNameCard(snapshot.data),
                  ),
                ),
              ),
            ]);
          } else {
            return buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildNameCard(UserResponse userResponse) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(children: [
        Text(
          userResponse.user.studFio,
          style: kProfileTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Номер зачетки: ${userResponse.user.zach}",
          style: kSpanTextStyle,
          textAlign: TextAlign.center,
        ),
      ]),
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
                    color: Style.Colors.titleColor,
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
                    style: kSpanTextStyle,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      userData,
                      style: kDataTextStyle,
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
