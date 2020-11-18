

import 'dart:async';

import 'package:rxdart/rxdart.dart';

enum WeekItem{EVEN,UNEVEN}

class WeekBloc{
  final BehaviorSubject<WeekItem> _weekController =
  BehaviorSubject<WeekItem>();

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

    void setCurrWeek(WeekItem weekItem){
      this.currWeek = weekItem;
    }
    close() {
      _weekController?.close();
    }
  }
  final weekBloc = WeekBloc();
