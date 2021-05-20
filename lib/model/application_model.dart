// To parse this JSON data, do
//
//     final application = applicationFromMap(jsonString);
import 'dart:convert';

import 'event_model.dart';

class GroupApplication {
  final String sphere;
  final int total;
  final List<Application> ratingElements;
  GroupApplication({this.sphere, this.ratingElements, this.total});
}

class Application {
  Application({
    this.status,
    this.id,
    this.event,
    this.comment,
    this.memberId,
    this.user,
    this.ammount,
    this.v,
  });

  String status;
  String id;
  Event event;
  String comment;
  String memberId;
  String user;
  int ammount;
  int v;

  Application copyWith({
    String status,
    String id,
    Event event,
    String comment,
    String memberId,
    String user,
    int ammount,
    int v,
  }) =>
      Application(
        status: status ?? this.status,
        id: id ?? this.id,
        event: event ?? this.event,
        comment: comment ?? this.comment,
        memberId: memberId ?? this.memberId,
        user: user ?? this.user,
        ammount: ammount ?? this.ammount,
        v: v ?? this.v,
      );

  factory Application.fromJson(String str) =>
      Application.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Application.fromMap(Map<String, dynamic> json) => Application(
        status: json["status"],
        id: json["_id"],
        event: json["event"] != null ? Event.fromMap(json["event"]) : null,
        comment: json["comment"],
        memberId: json["member_id"],
        user: json["user"],
        ammount: json["ammount"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "_id": id,
        "event": event.toMap(),
        "comment": comment,
        "member_id": memberId,
        "user": user,
        "ammount": ammount,
        "__v": v,
      };
}
