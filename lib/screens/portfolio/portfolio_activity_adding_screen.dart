import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';
import 'package:kai_mobile_app/style/constant.dart';

class PortfolioEventAddingScreen extends StatefulWidget {
  @override
  _PortfolioEventAddingScreenState createState() =>
      _PortfolioEventAddingScreenState();
}

class _PortfolioEventAddingScreenState
    extends State<PortfolioEventAddingScreen> {
  PortfolioBloc portfolioBloc;

  TextEditingController _sphereController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _levelController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  StreamSubscription<PortfolioState> streamSubscription;

  @override
  void initState() {
    portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    /* streamSubscription = portfolioBloc.listen((state) {
      if (state is PortfolioStateError) {
        var snakBar = SnackBar(
          content: Text(state.error),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
      }
    }); */
    super.initState();
  }

  @override
  void dispose() {
    //streamSubscription.cancel();
    super.dispose();
  }

  void _unfocus() {
    FocusScopeNode scope = FocusScope.of(context);
    if (scope.hasFocus) {
      scope.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Добавить новое мероприятие",
              ),
              centerTitle: true,
              elevation: 3.0,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _levelController,
                      decoration: InputDecoration(hintText: "Уровень"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _sphereController,
                      decoration:
                          InputDecoration(hintText: "Сфера деятельности"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Название"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _roleController,
                      decoration: InputDecoration(hintText: "Роли"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _linkController,
                      decoration: InputDecoration(hintText: "Ссылка"),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              portfolioBloc.add(PortfolioEventOfferEvent(
                                  name: _nameController.text,
                                  level: _levelController.text,
                                  sphere: _sphereController.text,
                                  link: _linkController.text));
                            },
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
                        ),
                        /*Expanded(
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
                                    elevation: 3.0,
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
                                      height: 250,
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text(
                                        activityOfferInformation,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )*/
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
