import 'dart:convert';

import 'package:hive/hive.dart';

import 'week_item.dart';

part 'lesson_model.g.dart';

@HiveType(typeId: 1)
class LessonModel {
  @HiveField(0)
  int dayNum;
  @HiveField(1)
  String dayTime;
  @HiveField(2)
  WeekItem dayEven;
  @HiveField(3)
  String dayDate;
  @HiveField(4)
  String disciplineName;
  @HiveField(5)
  String disciplineType;
  @HiveField(6)
  String audNum;
  @HiveField(7)
  String buildNum;
  @HiveField(8)
  String prepodName;
  @HiveField(9)
  String orgName;
  LessonModel({
    this.dayNum,
    this.dayTime,
    this.dayEven,
    this.dayDate,
    this.disciplineName,
    this.disciplineType,
    this.audNum,
    this.buildNum,
    this.prepodName,
    this.orgName,
  });

  LessonModel.fromJson(dynamic data){
    this.dayNum = int.parse(data["DayNum"].toString().trim());
    this.dayTime = data["DayTime"].toString().trim();
    this.dayEven = setWeek(data["DayDate"].toString().trim());
    this.disciplineName = data["DisciplineName"].toString().trim();
    this.disciplineType = setDisciplineType(data["DisciplineType"].toString().trim());
    this.audNum = data["AudNum"].toString().trim();
    this.buildNum = data["BuildNum"].toString().trim();
    this.prepodName = data["PrepodName"].toString().trim();
    this.orgName = data["OrgName"].toString().trim();
  }

  WeekItem setWeek(String week){
    if(week == "чет"){
      return WeekItem.EVEN;
    }else if(week == "неч"){
      return WeekItem.UNEVEN;
    }else if(week.length>0){
      this.dayDate = week;
      return null;
    } else{
      return null;
    }
  }

  String setDisciplineType(String disciplineType){
    if(disciplineType == "лек"){
      return "Лекция";
    }else if(disciplineType == "л.р."){
      return "Лабораторная работа";
    }else if(disciplineType == "пр"){
      return "Практика";
    } else{
      return disciplineType;
    }
  }

  LessonModel copyWith({
    int dayNum,
    String dayTime,
    WeekItem dayEven,
    String dayDate,
    String disciplineName,
    String disciplineType,
    String audNum,
    String buildNum,
    String prepodName,
    String orgName,
  }) {
    return LessonModel(
      dayNum: dayNum ?? this.dayNum,
      dayTime: dayTime ?? this.dayTime,
      dayEven: dayEven ?? this.dayEven,
      dayDate: dayDate ?? this.dayDate,
      disciplineName: disciplineName ?? this.disciplineName,
      disciplineType: disciplineType ?? this.disciplineType,
      audNum: audNum ?? this.audNum,
      buildNum: buildNum ?? this.buildNum,
      prepodName: prepodName ?? this.prepodName,
      orgName: orgName ?? this.orgName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayNum': dayNum,
      'dayTime': dayTime,
      'dayEven': dayEven,
      'dayDate': dayDate,
      'disciplineName': disciplineName,
      'disciplineType': disciplineType,
      'audNum': audNum,
      'buildNum': buildNum,
      'prepodName': prepodName,
      'orgName': orgName,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      dayNum: map['dayNum'],
      dayTime: map['dayTime'],
      dayEven: map['dayEven'],
      dayDate: map['dayDate'],
      disciplineName: map['disciplineName'],
      disciplineType: map['disciplineType'],
      audNum: map['audNum'],
      buildNum: map['buildNum'],
      prepodName: map['prepodName'],
      orgName: map['orgName'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LessonModel(dayNum: $dayNum, dayTime: $dayTime, dayEven: $dayEven, dayDate: $dayDate, disciplineName: $disciplineName, disciplineType: $disciplineType, audNum: $audNum, buildNum: $buildNum, prepodName: $prepodName, orgName: $orgName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LessonModel &&
      other.dayNum == dayNum &&
      other.dayTime == dayTime &&
      other.dayEven == dayEven &&
      other.dayDate == dayDate &&
      other.disciplineName == disciplineName &&
      other.disciplineType == disciplineType &&
      other.audNum == audNum &&
      other.buildNum == buildNum &&
      other.prepodName == prepodName &&
      other.orgName == orgName;
  }

  @override
  int get hashCode {
    return dayNum.hashCode ^
      dayTime.hashCode ^
      dayEven.hashCode ^
      dayDate.hashCode ^
      disciplineName.hashCode ^
      disciplineType.hashCode ^
      audNum.hashCode ^
      buildNum.hashCode ^
      prepodName.hashCode ^
      orgName.hashCode;
  }
}
