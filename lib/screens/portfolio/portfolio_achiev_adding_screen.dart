import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';

class PortfolioAchievAddingScreen extends StatefulWidget {
  @override
  _PortfolioAchievAddingScreenState createState() =>
      _PortfolioAchievAddingScreenState();
}

class _PortfolioAchievAddingScreenState
    extends State<PortfolioAchievAddingScreen> {
  String _selectedActivitySphere;
  bool _isSelected = false;
  List<File> files = List<File>();
  FocusNode _focus;

  @override
  void initState() {
    _focus = FocusNode();
    super.initState();
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(_focus);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => portfolioBloc.backToMenu(),
      child: GestureDetector(
        onTap: () {
          _focus.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Портфолио",
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: 240,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        child: Text("Учебная деятельность"),
                        value: "Учебная деятельность",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Научная деятельность"),
                        value: "Научная деятельность",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Спортивная деятельность"),
                        value: "Спортивная деятельность",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Культурно-массовая деятельность"),
                        value: "Культурно-массовая деятельность",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Общественная деятельность"),
                        value: "Общественная деятельность",
                      )
                    ],
                    onChanged: (String item) {
                      _selectedActivitySphere = item;
                    },
                    hint: Text("Сфера деятельности"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 240,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        child: Text("Учебная деятельность"),
                        value: "Учебная деятельность",
                      )
                    ],
                    onChanged: (String item) {
                      _selectedActivitySphere = item;
                    },
                    hint: Text("Студенческая активность"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 240,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        child: Text("Учебная деятельность"),
                        value: "Учебная деятельность",
                      )
                    ],
                    onChanged: (String item) {
                      _selectedActivitySphere = item;
                    },
                    hint: Text("Роль"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 240,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        child: Text("Учебная деятельность"),
                        value: "Учебная деятельность",
                      )
                    ],
                    onChanged: (String item) {
                      _selectedActivitySphere = item;
                    },
                    hint: Text("Уровень активности"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 240,
                  child: TextField(
                    focusNode: _focus,
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
                GestureDetector(
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
                    width: 200,
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
                ),
                GestureDetector(
                  onTap: () async {
                    FilePickerResult result;
                    try {
                      result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                    } catch (err) {
                      print("$err");
                    }
                    if (result != null) {
                      setState(() {
                        files = result.paths.map((file) => File(file)).toList();
                      });
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Добавить pdf файл",
                      style: Theme.of(context).textTheme.button,
                    )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  child: ListView.separated(
                    itemCount: files.length,
                    separatorBuilder: (BuildContext context, int i) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int i) {
                      return Container(child: Text(files[i].path));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
