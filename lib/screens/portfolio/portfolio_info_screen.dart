import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_mobile_app/style/constant.dart';

class PortfolioInfoScreen extends StatelessWidget {
  const PortfolioInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Добавить новое мероприятие"),
          centerTitle: true,
          elevation: 3.0,
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: activityOfferInformation,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(45, 0, 45, 15),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 45,
                          //width: _size.width * 0.5,
                          decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Ок",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            )));
  }
}
