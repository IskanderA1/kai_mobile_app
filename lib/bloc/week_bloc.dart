import 'dart:async';

import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:week_of_year/week_of_year.dart';


enum WeekItem { EVEN, UNEVEN }

class WeekBloc {
  final MobileRepository _repository = MobileRepository();
  final BehaviorSubject<WeekItem> _weekController = BehaviorSubject<WeekItem>();

  WeekItem currWeek = WeekItem.EVEN;

  Stream<WeekItem> get weekStream => _weekController.stream;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _weekController.sink.add(WeekItem.EVEN);
        break;
      case 1:
        _weekController.sink.add(WeekItem.UNEVEN);
        break;
    }
  }

  getCurrWeek() async {
    final DateTime date = DateTime.now();
    print("DataTime = ${date.weekOfYear%2==0?"UNEVEN":"EVEN"}");
    date.weekOfYear%2==0? _weekController.sink.add(WeekItem.UNEVEN):_weekController.sink.add(WeekItem.EVEN);
  }

  close() {
    _weekController?.close();
  }
}

final weekBloc = WeekBloc();
