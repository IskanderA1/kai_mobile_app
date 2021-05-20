// To parse this JSON data, do
//
//     final event = eventFromMap(jsonString);

import 'dart:convert';

import 'package:kai_mobile_app/model/poin_model.dart';

class Event {
  Event({
    this.points,
    this.id,
    this.title,
    this.sphere,
    this.level,
    this.v,
  });

  List<Point> points;
  String id;
  String title;
  String sphere;
  String level;
  int v;

  Event copyWith({
    List<Point> points,
    String id,
    String title,
    String sphere,
    String level,
    int v,
  }) =>
      Event(
        points: points ?? this.points,
        id: id ?? this.id,
        title: title ?? this.title,
        sphere: sphere ?? this.sphere,
        level: level ?? this.level,
        v: v ?? this.v,
      );

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
      points: List<Point>.from(json["points"].map((x) => Point.fromMap(x))),
      id: json["_id"],
      title: json["title"],
      sphere: json["sphere"],
      level: json["level"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toMap() => {
        "points": List<dynamic>.from(points.map((x) => x.toMap())),
        "_id": id,
        "title": title,
        "sphere": sphere,
        "level": level,
        "__v": v,
      };
}
