import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/porfolio_menu_bloc.dart';
import 'package:kai_mobile_app/bloc/portfolio/portfolio_bloc.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/model/application_model.dart';
import 'package:kai_mobile_app/model/rating_list_models.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_achiev_adding_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_global_rating_screen.dart';
import 'package:kai_mobile_app/screens/portfolio/portfolio_profile_screen.dart';

class PortfolioMenuScreen extends StatefulWidget {
  @override
  _PortfolioMenuScreenState createState() => _PortfolioMenuScreenState();
}

class _PortfolioMenuScreenState extends State<PortfolioMenuScreen> {
  Size _size;
  ProfileBloc profileBloc;
  PortfolioBloc portfolioBloc;
  StreamSubscription<ProfileState> profileSub;
  StreamSubscription<PortfolioState> portfolioSub;
  ProfileStateAuthorized _profileState;
  PortfolioStateLoaded _portfolioStateLoaded;

  List<Application> applications;
  List<RatingElements> ratings;
  List<GroupApplication> grupApp;

  int placeInTop = 0;
  int totalScore = 0;
  RatingElements _userRating;

  @override
  void initState() {
    applications = List<Application>.empty();
    ratings = List<RatingElements>.empty();
    grupApp = List<GroupApplication>.empty();
    profileBloc ??= BlocProvider.of<ProfileBloc>(context);
    portfolioBloc ??= BlocProvider.of<PortfolioBloc>(context);

    _profileState = profileBloc.state;

    profileSub = profileBloc.listen((state) {
      if (state is ProfileStateAuthorized) {
        _profileState = state;
      }
    });

    portfolioSub = portfolioBloc.listen((state) {
      if (state is PortfolioStateLoaded) {
        applications = state.applicationsList;
        ratings = state.ratingList;
        grupApp = state.grouppedApplication;
        fillByLists();
      }
    });
    if (portfolioBloc.state is PortfolioStateLoaded) {
      _portfolioStateLoaded = portfolioBloc.state;
    }
    if (_portfolioStateLoaded != null) {
      applications = _portfolioStateLoaded.applicationsList;
      ratings = _portfolioStateLoaded.ratingList;
      grupApp = _portfolioStateLoaded.grouppedApplication;
      fillByLists();
    }
    super.initState();
  }

  fillByLists() {
    if (applications == null || ratings == null) {
      return;
    }
    String _currentUserId = _profileState.user.zach;

    ratings.forEach((element) {
      placeInTop++;
      if (element.userId.zachetNum == _currentUserId) {
        _userRating = element.copyWith();
      }
    });
    if (_userRating == null) {
      totalScore = 0;
      placeInTop = 0;
    } else {
      totalScore = _userRating.total;
    }
    //ratings.removeWhere((element) => _currentUserId == element.userId.zachetNum);
  }

  @override
  void dispose() {
    /* portfolioSub.cancel(); */
    profileSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
        child: WillPopScope(
            onWillPop: () async {
              /*portfolioBloc.add(PortfolioEventNavigate(
                                tab: PortfMenuItems.Menu));*/
              return false;
            },
            child: DefaultTabController(
                length: 2,
                child: BlocConsumer<PortfolioBloc, PortfolioState>(
                  listener: (context, state) {
                    if (state is PortfolioStateLoaded) {
                      applications = state.applicationsList;
                      ratings = state.ratingList;
                      grupApp = state.grouppedApplication;
                      fillByLists();
                    }
                  },
                  builder: (context, state) {
                    /*if(state is PortfolioStateNeedInit){

                    }*/
                    if (state is PortfolioStateLoaded) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                    color: Theme.of(context).primaryColor,
                                    child: Image.asset(
                                      'assets/placeholder.png',
                                      width: MediaQuery.of(context).size.width,
                                    )),
                              )),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_profileState.user.studFio} ${_profileState.user.groupNum}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Место в рейтинге: $placeInTop",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        "Баллы: $totalScore",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          centerTitle: true,
                          elevation: 0,
                          bottom: TabBar(
                            tabs: [
                              Tab(text: 'Личные достижения'),
                              Tab(text: 'Рейтинг'),
                            ],
                          ),
                        ),
                        body: TabBarView(children: [
                          _buildUserAchievs(state, context),
                          _buildGlobalRating(state)
                        ]),
                      );
                    }
                    return Container();
                  },
                ))));
  }

  Column _buildGlobalRating(PortfolioStateLoaded state) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Card(
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_profileState.user.studFio,
                        style: Theme.of(context).primaryTextTheme.headline6),
                    Spacer(),
                    Text(_userRating != null ? '${_userRating.total}' : '_',
                        style: Theme.of(context).primaryTextTheme.headline6)
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.ratingList.length,
                itemBuilder: (context, ind) {
                  return Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(state.ratingList[ind].userId.name,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6),
                            Spacer(),
                            Text('${state.ratingList[ind].total}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6)
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ],
    );
  }

  Stack _buildUserAchievs(PortfolioStateLoaded state, BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: state.grouppedApplication.length,
            itemBuilder: (context, ind) {
              return Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(state.grouppedApplication[ind].sphere,
                            style:
                                Theme.of(context).primaryTextTheme.headline6),
                        Spacer(),
                        Text('${state.grouppedApplication[ind].total}',
                            style: Theme.of(context).primaryTextTheme.headline6)
                      ],
                    ),
                  ),
                ),
              );
            }),
        Positioned(
            bottom: 15,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: portfolioBloc,
                                child: PortfolioAchievAddingScreen(),
                              )));
                },
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 45,
                    width: _size.width * 0.5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "Добавить",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
