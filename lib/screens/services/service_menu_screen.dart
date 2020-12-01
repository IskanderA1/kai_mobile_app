import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;
import 'package:kai_mobile_app/widgets/weather_widget.dart';

class ServiceMenuScreen extends StatefulWidget {
  @override
  _ServiceMenuScreenState createState() => _ServiceMenuScreenState();
}

class _ServiceMenuScreenState extends State<ServiceMenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Сервисы",
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Style.Colors.mainColor,
        shadowColor: Colors.grey[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
              Container(
                height: MediaQuery.of(context).size.height/2,
                  child: Padding(
                    padding: EdgeInsets.only( left: 15, right: 15),
                    child: Container(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return _buildServiceMenuItem(index);
                      }),
                    ),
                  ),
              ),
                Container(
                child: Column(
                  children: [buildWeatherWidget(context),]
                  ),
              ), 
              
          ],
        ),
      ),
    );
  }

  Widget _buildServiceMenuItem(int index) {

    IconData icon = Icons.event_note;
    String label = "Занятия";
    switch(index){
      case 0:
        icon = Icons.event_note;
        label = "Занятия";
        break;
      case 1:
        icon = Icons.event_available_rounded;
        label = "Экзамены";
        break;
      case 2:
        icon = Icons.group;
        label = "Моя группа";
        break;
      case 3:
        icon = Icons.school;
        label = "БРС";
        break;
      case 4:
        icon = Icons.map;
        label = "Карта";
        break;
      case 5:
        icon = Icons.directions_run;
        label = "Активности";
        break;
      case 6:
        icon = Icons.text_snippet;
        label = "Документы";
        break;
      case 7:
        icon = Icons.done;
        label = "Контроль";
        break;
    }
    return FlatButton(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Style.Colors.titleColor,
              size: 40,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              label,
              style: kServiceMenuItemTextStyle,
            ),
          ],
        ),
      ),
      onPressed: (){

        serviceMenu.pickItem(index);
      },
    );
  }
}
