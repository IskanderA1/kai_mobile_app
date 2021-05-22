// To parse this JSON data, do
//
//     final member = memberFromMap(jsonString);

import 'dart:convert';

class Member {
    Member({
        this.id,
        this.title,
        this.v,
    });

    String id;
    String title;
    int v;

    Member copyWith({
        String id,
        String title,
        int v,
    }) => 
        Member(
            id: id ?? this.id,
            title: title ?? this.title,
            v: v ?? this.v,
        );

    factory Member.fromJson(String str) => Member.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Member.fromMap(Map<String, dynamic> json) => Member(
        id: json["_id"],
        title: json["title"],
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "__v": v,
    };
}
