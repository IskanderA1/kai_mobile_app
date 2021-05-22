import 'package:hive/hive.dart';
part 'week_item.g.dart';

@HiveType(typeId: 0)
enum WeekItem { 
  @HiveField(0)
  EVEN, 
  @HiveField(1)
  UNEVEN 
}