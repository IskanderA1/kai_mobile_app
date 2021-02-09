import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(55.797056, 49.114957),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: MarkerId('Kai1'),
          position: LatLng(55.797048, 49.114148),
          onTap: () {
            showStickyFlexibleBottomSheet(
                headerHeight: 60,
                minHeaderHeight: 60,
                minHeight: 0.4,
                maxHeight: 0.85,
                anchors: [0.4, 0.6, 0.85],
                context: context,
                headerBuilder: (context, double offset) {
                  return HeaderWidget(
                    offset: offset,
                    name: "Первое здание",
                  );
                },
                builder: (context, double offset) {
                  return SliverChildListDelegate(<Widget>[
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: MediaQuery.of(context).size.height * 0.85 - 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                              "https://gge.ru/upload/iblock/1ec/kai2.jpg"),
                          myDivider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("ул. Карла Маркса, 10\nОстановка КАИ")
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]);
                });
          }),
      Marker(
          markerId: MarkerId('Kai2'),
          position: LatLng(55.822680, 49.136085),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Второе здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://pbs.twimg.com/media/Dg7rJalXkAAMg09.jpg:large"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Четаева, 18\n(пересечение улиц Четаева и Амирхана)\nОстановка "ул. Четаева"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai3'),
          position: LatLng(55.792372, 49.137514),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Третье здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/2/2d/%D0%9A%D0%9D%D0%98%D0%A2%D0%A3-%D0%9A%D0%90%D0%98%2C_3-%D0%B5_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5.jpg"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Льва Толстого, 15\nОстановка "ул.Л.Толстого"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai4'),
          position: LatLng(55.793131, 49.137397),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Четвертое здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://art16.ru/gallery2/d/899825-3/dsc08768.jpg"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Горького, 28/17\nОстановка "ул.Л.Толстого"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai5'),
          position: LatLng(55.797139, 49.124183),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Пятое здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://kartarf.ru/images/heritage/1080/7/71061.jpg"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Карла Маркса, 31/7\nОстановка "Площадь Свободы"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai6'),
          position: LatLng(55.854229, 49.098060),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Шестое здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://kai.ru/documents/10181/5714768/6+%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5.jpg/138cdf1e-640c-4f6d-8ca8-d6335507507e?t=1484826009897"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('ул. Дементьева, 2а\nОстановка "Институт"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai7'),
          position: LatLng(55.796941, 49.133849),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Седьмое здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://pbs.twimg.com/media/DioKW-EX0AATjNu.jpg:large"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Большая Красная, 55\nОстановка "Гоголя"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('Kai8'),
          position: LatLng(55.820845, 49.135951),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "Восьмое здание",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://vuzyi.lancmanschool.ru/assets/blog/images/%D0%9A%D0%9D%D0%98%D0%A2%D0%A3%D0%9A%D0%90%D0%98.jpg"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'ул. Четаева, 18а\nОстановка "Чистопольская"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
      Marker(
          markerId: MarkerId('KaiOlimp'),
          position: LatLng(55.820243, 49.139490),
          onTap: () => showStickyFlexibleBottomSheet(
              headerHeight: 60,
              minHeaderHeight: 60,
              minHeight: 0.4,
              maxHeight: 0.85,
              anchors: [0.4, 0.6, 0.85],
              context: context,
              headerBuilder: (context, double offset) {
                return HeaderWidget(
                  offset: offset,
                  name: "КАИ Олимп",
                );
              },
              builder: (context, double offset) {
                return SliverChildListDelegate(<Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height * 0.85 - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://i1.photo.2gis.com/images/branch/21/2955487284540671_3282.jpg"),
                        myDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'Чистопольская ул., 65А\nОстановка "Чистопольская"')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
    };
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Карта",
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

class HeaderWidget extends StatefulWidget {
  final String name;
  final double offset;
  const HeaderWidget({
    Key key,
    @required this.offset,
    @required this.name,
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.offset == 0.85 ? 0 : 40),
                topRight: Radius.circular(widget.offset == 0.85 ? 0 : 40)),
            color: Theme.of(context).scaffoldBackgroundColor),
        duration: Duration(milliseconds: 700),
        height: 60,
        onEnd: () {},
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            )));
  }
}

Divider myDivider() {
  return Divider(
    color: Color(0xF2707070),
    indent: 15,
    endIndent: 15,
    thickness: 0.6,
  );
}
