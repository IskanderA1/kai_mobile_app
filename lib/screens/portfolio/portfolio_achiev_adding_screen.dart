import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';
import 'package:kai_mobile_app/model/event_model.dart';
import 'package:kai_mobile_app/model/member_model.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_activity_adding_screen.dart';

class PortfolioAchievAddingScreen extends StatefulWidget {
  @override
  _PortfolioAchievAddingScreenState createState() =>
      _PortfolioAchievAddingScreenState();
}

class _PortfolioAchievAddingScreenState
    extends State<PortfolioAchievAddingScreen> {
  TextEditingController _ammountController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  String _selectedActivitySphere;

  String _selectedEventId;
  Event _selectedEvent;

  String _selectedLevel;

  Member _selectedMember;

  bool _isSelected = false;
  List<File> files = List<File>.empty(growable: true);
  FocusNode _focus;
  ScrollController _scrollController = ScrollController();
  PortfolioBloc portfolioBloc;
  PortfolioStateLoaded state;

  List<DropdownMenuItem<String>> sphereList;
  List<DropdownMenuItem<Event>> eventsList;
  List<DropdownMenuItem<Member>> membersList;
  List<DropdownMenuItem<String>> levelsList;

  int ammount;

  @override
  void initState() {
    _focus = FocusNode();
    portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    if (portfolioBloc.state is PortfolioStateLoaded) {
      state = portfolioBloc.state;
      fillByState();
    }
    super.initState();
  }

  void fillByState() {
    sphereList = state.uniqueSpheres
        .map((e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ))
        .toList();
    eventsList = state.events
        .map((e) => DropdownMenuItem<Event>(
              child: Text(e.title),
              value: e,
            ))
        .toList();
    membersList = state.membersList
        .map((e) => DropdownMenuItem<Member>(
              child: Text(e.title),
              value: e,
            ))
        .toList();
    levelsList = state.levelsList
        .map((e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ))
        .toList();
  }

  void fillByEvent(Event event) {
    if (event == null) {
      fillByState();
      return;
    }
    _selectedEventId = event.id;
    _selectedEvent = event;
    _selectedLevel = event.level;
    ammount = event.points.first.ammount;
    String memberId = event.points.first.memberId;
    _selectedMember =
        state.membersList.firstWhere((element) => element.id == memberId);
    ammount = event.points
        .firstWhere((element) => element.memberId == _selectedMember.id)
        .ammount;
    _ammountController.text = '$ammount';

    _selectedActivitySphere = event.sphere;

    List<String> eventMembIds = event.points.map((e) => e.memberId).toList();

    membersList.clear();

    state.membersList.forEach((member) {
      if (eventMembIds.contains(member.id)) {
        membersList.add(DropdownMenuItem<Member>(
          child: Text(member.title),
          value: member,
        ));
      }
    });
    setState(() {});
  }

  void sortBySphere(String sphere) {
    eventsList = state.events
        .where((element) => element.sphere == sphere)
        .map((e) => DropdownMenuItem<Event>(
              child: Text(e.title),
              value: e,
            ))
        .toList();
    setState(() {});
  }

  void fillByMember(Member member) {
    ammount = null;
    for (var element in eventsList) {
      for (var e in element.value.points) {
        if (e.memberId == member.id) {
          ammount = e.ammount;
          break;
        }
      }
      if (ammount != null) {
        break;
      }
    }
    if (ammount != null) {
      _ammountController.text = '$ammount';
    }
    if (eventsList.isEmpty) {
      eventsList.add(DropdownMenuItem<Event>(
        child: Text('Пусто'),
        value: null,
      ));
    }
    setState(() {
      _selectedMember = member;
    });
  }

  void fillByLevel(String level) {
    ammount = null;

    eventsList = state.events
        .where((element) => element.level == level)
        .map((e) => DropdownMenuItem<Event>(
              child: Text(e.title),
              value: e,
            )).toList();
    if (ammount != null) {
      _ammountController.text = '$ammount';
    } else {
      _ammountController.text = '';
    }
    if (eventsList.isEmpty) {
      eventsList.add(DropdownMenuItem<Event>(
        child: Text('Пусто'),
        value: null,
      ));
    }
    setState(() {
      _selectedLevel = level;
    });
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(_focus);
  }

  void sendActivity() {
    if (_selectedEvent == null ||
        _selectedEventId == null ||
        _selectedMember == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(
          seconds: 2,
        ),
        content: Text("Выберите все поля"),
      ));
      return;
    }
    portfolioBloc.add(PortfolioEventSentApplic(
        eventId: _selectedEventId,
        memberId: _selectedMember.id,
        comment: _commentController.text,
        file: files.isNotEmpty ? files[0] : null));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Добавить достижение"),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: sphereList,
                    value: _selectedActivitySphere,
                    onChanged: (String item) {
                      _selectedActivitySphere = item;
                      sortBySphere(item);
                    },
                    hint: Text("Сфера деятельности"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: levelsList,
                    value: _selectedLevel,
                    onChanged: (String item) {
                      fillByLevel(item);
                    },
                    hint: Text("Уровень активности"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: DropdownButton<Event>(
                    isExpanded: true,
                    itemHeight: 70,
                    items: eventsList,
                    value: _selectedEvent,
                    onChanged: (Event item) {
                      fillByEvent(item);
                    },
                    hint: Text("Название мероприятия"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: DropdownButton<Member>(
                    isExpanded: true,
                    items: membersList,
                    value: _selectedMember,
                    onChanged: (Member item) {
                      fillByMember(item);
                    },
                    hint: Text("Роль"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: TextField(
                    focusNode: _focus,
                    controller: _ammountController,
                    onChanged: (String str) {
                      ammount = int.parse(str);
                    },
                    decoration: InputDecoration(
                      labelText: "Начисляемыые баллы",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextField(
                    controller: _commentController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Комментарий",
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                /*GestureDetector(
                  onTap: () async {
                    final File photo =
                        await ImagePicker.pickImage(source: ImageSource.gallery)
                            .then((file) => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Image.file(file);
                                }));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Добавить фото",
                      style: Theme.of(context).textTheme.button,
                    )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),*/
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult result;
                          try {
                            result = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'png', 'jpg'],
                            );
                          } catch (err) {
                            print("$err");
                          }
                          if (result != null) {
                            setState(() {
                              files = result.paths
                                  .map((file) => File(file))
                                  .toList();
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Добавить документ",
                            style: Theme.of(context).textTheme.button,
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.report,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 8.0,
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 10),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: InkWell(
                                          child: Text('Ok'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                content: Container(
                                  height: 100,
                                  padding: EdgeInsets.all(15),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Поддерживаются следующие форматы: .pdf, .png, .jpg",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: files.length,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int i) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(files[i].path.split('/').last)),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                files.removeAt(i);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete,
                              ),
                            ),
                          )
                        ],
                      ));
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: sendActivity,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Отправить",
                      style: Theme.of(context).textTheme.button,
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: portfolioBloc,
                                    child: PortfolioEventAddingScreen(),
                                  )));
                    },
                    child: Text(
                      'Предложить мероприятие',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
