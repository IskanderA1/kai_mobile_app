// To parse this JSON data, do
//
//     final ratingElements = ratingElementsFromMap(jsonString);

import 'dart:convert';

class RatingElements {
    RatingElements({
        this.id,
        this.userId,
        this.v,
        this.ratingElementId,
        this.total,
    });

    String id;
    UserId userId;
    int v;
    String ratingElementId;
    int total;

    RatingElements copyWith({
        String id,
        UserId userId,
        int v,
        String ratingElementId,
        int total,
    }) => 
        RatingElements(
            id: id ?? this.id,
            userId: userId ?? this.userId.copyWith(),
            v: v ?? this.v,
            ratingElementId: ratingElementId ?? this.ratingElementId,
            total: total ?? this.total,
        );

    factory RatingElements.fromJson(String str) => RatingElements.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RatingElements.fromMap(Map<String, dynamic> json) => RatingElements(
        id: json["_id"],
        userId: UserId.fromMap(json["user_id"]),
        v: json["__v"],
        ratingElementId: json["id"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "user_id": userId.toMap(),
        "__v": v,
        "id": ratingElementId,
        "total": total,
    };
}

class UserId {
    UserId({
        this.zachetNum,
        this.id,
        this.profileId,
        this.studId,
        this.group,
        this.name,
        this.status,
        this.teachProfile,
        this.speciality,
        this.form,
        this.competition,
        this.education,
        this.institute,
        this.cafedra,
        this.created,
        this.v,
    });

    String zachetNum;
    String id;
    String profileId;
    String studId;
    Group group;
    String name;
    String status;
    Cafedra teachProfile;
    Speciality speciality;
    String form;
    String competition;
    Education education;
    Cafedra institute;
    Cafedra cafedra;
    DateTime created;
    int v;

    UserId copyWith({
        String zachetNum,
        String id,
        String profileId,
        String studId,
        Group group,
        String name,
        String status,
        Cafedra teachProfile,
        Speciality speciality,
        String form,
        String competition,
        Education education,
        Cafedra institute,
        Cafedra cafedra,
        DateTime created,
        int v,
    }) => 
        UserId(
            zachetNum: zachetNum ?? this.zachetNum,
            id: id ?? this.id,
            profileId: profileId ?? this.profileId,
            studId: studId ?? this.studId,
            group: group ?? this.group,
            name: name ?? this.name,
            status: status ?? this.status,
            teachProfile: teachProfile ?? this.teachProfile,
            speciality: speciality ?? this.speciality,
            form: form ?? this.form,
            competition: competition ?? this.competition,
            education: education ?? this.education,
            institute: institute ?? this.institute,
            cafedra: cafedra ?? this.cafedra,
            created: created ?? this.created,
            v: v ?? this.v,
        );

    factory UserId.fromJson(String str) => UserId.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserId.fromMap(Map<String, dynamic> json) => UserId(
        zachetNum: json["zachet_num"],
        id: json["_id"],
        profileId: json["profile_id"],
        studId: json["stud_id"],
        group: Group.fromMap(json["group"]),
        name: json["name"],
        status: json["status"],
        teachProfile: Cafedra.fromMap(json["teach_profile"]),
        speciality: Speciality.fromMap(json["speciality"]),
        form: json["form"],
        competition: json["competition"],
        education: Education.fromMap(json["education"]),
        institute: Cafedra.fromMap(json["institute"]),
        cafedra: Cafedra.fromMap(json["cafedra"]),
        created: DateTime.parse(json["created"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "zachet_num": zachetNum,
        "_id": id,
        "profile_id": profileId,
        "stud_id": studId,
        "group": group.toMap(),
        "name": name,
        "status": status,
        "teach_profile": teachProfile.toMap(),
        "speciality": speciality.toMap(),
        "form": form,
        "competition": competition,
        "education": education.toMap(),
        "institute": institute.toMap(),
        "cafedra": cafedra.toMap(),
        "created": created.toIso8601String(),
        "__v": v,
    };
}

class Cafedra {
    Cafedra({
        this.id,
        this.title,
    });

    String id;
    String title;

    Cafedra copyWith({
        String id,
        String title,
    }) => 
        Cafedra(
            id: id ?? this.id,
            title: title ?? this.title,
        );

    factory Cafedra.fromJson(String str) => Cafedra.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cafedra.fromMap(Map<String, dynamic> json) => Cafedra(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
    };
}

class Education {
    Education({
        this.level,
        this.qualification,
        this.cycle,
    });

    String level;
    String qualification;
    String cycle;

    Education copyWith({
        String level,
        String qualification,
        String cycle,
    }) => 
        Education(
            level: level ?? this.level,
            qualification: qualification ?? this.qualification,
            cycle: cycle ?? this.cycle,
        );

    factory Education.fromJson(String str) => Education.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Education.fromMap(Map<String, dynamic> json) => Education(
        level: json["level"],
        qualification: json["qualification"],
        cycle: json["cycle"],
    );

    Map<String, dynamic> toMap() => {
        "level": level,
        "qualification": qualification,
        "cycle": cycle,
    };
}

class Group {
    Group({
        this.id,
        this.groupId,
        this.title,
    });

    String id;
    String groupId;
    String title;

    Group copyWith({
        String id,
        String groupId,
        String title,
    }) => 
        Group(
            id: id ?? this.id,
            groupId: groupId ?? this.groupId,
            title: title ?? this.title,
        );

    factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Group.fromMap(Map<String, dynamic> json) => Group(
        id: json["_id"],
        groupId: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "id": groupId,
        "title": title,
    };
}

class Speciality {
    Speciality({
        this.id,
        this.code,
        this.title,
    });

    String id;
    String code;
    String title;

    Speciality copyWith({
        String id,
        String code,
        String title,
    }) => 
        Speciality(
            id: id ?? this.id,
            code: code ?? this.code,
            title: title ?? this.title,
        );

    factory Speciality.fromJson(String str) => Speciality.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Speciality.fromMap(Map<String, dynamic> json) => Speciality(
        id: json["id"],
        code: json["code"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "title": title,
    };
}
