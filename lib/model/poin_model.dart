import 'dart:convert';

class Point {
    Point({
        this.memberId,
        this.ammount,
    });

    String memberId;
    double ammount;

    Point copyWith({
        String memberId,
        double ammount,
    }) => 
        Point(
            memberId: memberId ?? this.memberId,
            ammount: ammount ?? this.ammount,
        );

    factory Point.fromJson(String str) => Point.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Point.fromMap(Map<String, dynamic> json) => Point(
        memberId: json["member_id"],
        ammount: double.parse(json["ammount"].toString()),
    );

    Map<String, dynamic> toMap() => {
        "member_id": memberId,
        "ammount": ammount,
    };
}

