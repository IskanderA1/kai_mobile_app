import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kai_mobile_app/bloc/send_report_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/report_response.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  File _selectedFile;
  bool _inProcess = false;

  final _reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _reportController.clear();
    _reportController.dispose();
    super.dispose();
  }

  Widget _buildReportTextField() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _reportController,
              style: TextStyle(
                color: Style.Colors.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.report,
                  color: Style.Colors.titleColor,
                ),
                hintText: 'Введите проблему',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetPhotoLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text("Добавьте фото", style: kLabelStyle),
    );
  }

  final snackBar = SnackBar(
    content: StreamBuilder<ReportResponse>(
        stream: sendReportBloc.subject.stream,
        builder: (context, AsyncSnapshot<ReportResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.text != null && snapshot.data.text.length > 0) {
              return Text(
                snapshot.data.text,
                style: TextStyle(
                  color: Style.Colors.mainColor,
                ),
              );
            }
          }
          return SizedBox();
        }),
    action: SnackBarAction(
      label: 'Ок',
      //textColor: Style.Colors.titleColor,
      onPressed: () {},
    ),
  );

  Widget _buildSendReportBtn() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await sendReportBloc.sendReport(
              _selectedFile, _reportController.text);
          Scaffold.of(context).showSnackBar(snackBar);
          if (sendReportBloc.subject.stream.value.text ==
              "Ваша заявка принята") {
            setState(() {
              _selectedFile = null;
            });
            _reportController.clear();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Style.Colors.titleColor,
        child: Text(
          'Отправить',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Image.file(
          _selectedFile,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Style.Colors.mainColor,
            toolbarTitle: "Обрезать",
            statusBarColor: Style.Colors.titleColor,
            backgroundColor: Colors.white,
            toolbarWidgetColor: Style.Colors.titleColor,
            activeControlsWidgetColor: Style.Colors.titleColor,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Style.Colors.titleColor,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Контроль",
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        shadowColor: Colors.grey[100],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildReportTextField(),
                _buildSetPhotoLabel(),
                getImageWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        elevation: 5,
                        minWidth: 150,
                        color: Style.Colors.titleColor,
                        child: Text(
                          "Камера",
                          style: TextStyle(color: Style.Colors.mainColor),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        }),
                    MaterialButton(
                        elevation: 5,
                        minWidth: 150,
                        color: Style.Colors.mainColor,
                        child: Text(
                          "Из устройства",
                          style: TextStyle(color: Style.Colors.titleColor),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        })
                  ],
                ),
                _buildSendReportBtn(),
              ],
            ),
          ),
          (_inProcess)
              ? Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Center(
                    child: buildLoadingWidget(),
                  ),
                )
              : Center(),
          StreamBuilder<ReportResponse>(
              stream: sendReportBloc.subject.stream,
              builder: (context, AsyncSnapshot<ReportResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.text == "Loading") {
                    return Container(
                      color: Style.Colors.mainColor,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: buildLoadingWidget(),
                    );
                  } else {
                    return Center();
                  }
                }
                return SizedBox();
              }),
        ],
      ),
    );
  }
}
