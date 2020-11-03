import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/get_group_mate_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/group_mate_respose.dart';
import 'package:kai_mobile_app/model/group_mate_model.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class MyGroupScreen extends StatefulWidget {
  @override
  _MyGroupScreenState createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  @override
  void initState() {
    getGroupMateBloc.getGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Моя группа",
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        shadowColor: Colors.grey[100],
      ),
      body: StreamBuilder(
          stream: getGroupMateBloc.subject,
          builder: (context, AsyncSnapshot<GroupMateResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return Center(
                  child: Text(snapshot.data.error),
                );
              }
              return _buildListView(snapshot.data.group);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Ошибка"),
              );
            } else {
              return buildLoadingWidget();
            }
          }),
    );
  }

  Widget _buildListView(List<GroupMateModel> groupList) {
    return ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          return _buildGroupItem(groupList[index]);
        });
  }

  Widget _buildGroupItem(GroupMateModel groupMate) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Container(
        height: 140,

        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      groupMate.studentFIO,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[500], width: 2.0),
                  ),
                  color: Style.Colors.titleColor,
                ),
              ),
            ),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[200], width: 2.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text("Телефон"),
                              SizedBox(
                                height: 12,
                              ),
                              Text(groupMate.studentPhone),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text("E-Mail"),
                              SizedBox(
                                height: 12,
                              ),
                              Text(groupMate.studentEmail),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
