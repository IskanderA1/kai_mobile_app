import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile_app/model/activity_model.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/style/constant.dart';

import 'package:kai_mobile_app/style/theme.dart' as Style;
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class DetailActivityScreen extends StatefulWidget {
  final ActivityModel activityModel;

  DetailActivityScreen(this.activityModel);

  @override
  _DetailActivityScreenState createState() =>
      _DetailActivityScreenState(activityModel);
}

class _DetailActivityScreenState extends State<DetailActivityScreen> {
  ActivityModel _activityModel;

  _DetailActivityScreenState(ActivityModel activityModel) {
    this._activityModel = activityModel;
  }

  @override
  Widget build(BuildContext context) {
    /* DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(_activityModel.date);*/
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: false,
            pinned: true,
            toolbarHeight: 60,
            expandedHeight: 240.0,
            elevation: 0,
            flexibleSpace: _SliverAppBar(
              activityModel: _activityModel,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            alignment: Alignment.topCenter,
                            child: Text(
                              _activityModel.title,
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Style.Colors.standardTextColor,
                                    offset: Offset(1, 1.0),
                                  ),
                                ],
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: 'OpenSans',
                              ),
                            )),
                        Text(
                          _activityModel.desc,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Руководитель: ",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text("${_activityModel.leader}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Адрес: ",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text("${_activityModel.address}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Расписание: ",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text("${_activityModel.date}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Ссылки: ",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Linkify(
                                    text: "${_activityModel.links}",
                                    onOpen: (link) async {
                                      if (await canLaunch(link.url)) {
                                        await launch(link.url);
                                      } else {
                                        throw 'Could not launch $link';
                                      }
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }, childCount: 1),
          )
        ]),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final ActivityModel activityModel;
  const _SliverAppBar({Key key, this.activityModel}) : super(key: key);

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        print(c.biggest.height);
        return Opacity(
          opacity: opacity,
          child: Hero(
            transitionOnUserGestures: true,
            tag: activityModel,
            child: Transform.scale(
              scale: 1.0,
              child: activityModel.image != null
                  ? Image.network(
                      MobileRepository.mainUrl + activityModel.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Container(color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
