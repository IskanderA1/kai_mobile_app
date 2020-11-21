import 'package:flutter/material.dart';
import 'package:kai_mobile_app/model/activity_model.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/style/constant.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;
import 'dart:math' as math;

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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Style.Colors.titleColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: false,
            pinned: true,
            toolbarHeight: 60,
            expandedHeight: 240.0,
            backgroundColor: Colors.white,
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
                        Text(_activityModel.desc),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Text("Руководитель: ",style: kLabelStyle,)),
                              Expanded(flex:2, child: Text("${_activityModel.leader}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Text("Адрес: ",style: kLabelStyle,)),
                              Expanded(flex:2, child: Text("${_activityModel.address}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Text("Расписание: ",style: kLabelStyle,)),
                              Expanded(flex:2, child: Text("${_activityModel.date}"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(flex:1, child: Text("Ссылки: ",style: kLabelStyle,)),
                              Expanded(flex:2, child: Text("${_activityModel.links}"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  );
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
        return Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
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
            ),
            Opacity(
              opacity: Interval(fadeStart, fadeEnd).transform(t),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 84,
                  child: Text(
                    activityModel.title,
                    maxLines: (4 - 240 ~/ c.biggest.height) > 0
                        ? (4 - 240 ~/ c.biggest.height)
                        : 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 84,
                  child: Hero(
                    flightShuttleBuilder: _flightShuttleBuilder,
                    tag: activityModel.id,
                    child: Text(
                      activityModel.title,
                      maxLines: (4 - 240 ~/ c.biggest.height) > 0
                          ? (4 - 240 ~/ c.biggest.height)
                          : 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Style.Colors.standardTextColor,
                            offset: Offset(1, 1.0),
                          ),
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
