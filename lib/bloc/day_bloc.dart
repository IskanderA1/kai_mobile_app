import 'dart:async';


enum DayItem{MO,TU,WE,TH,FR,SA}


class DayWeekBloc{

  final StreamController<DayItem> _dayController =
  StreamController<DayItem>.broadcast();



  DayItem currDay = DayItem.WE;

  Stream<DayItem> get dayStream => _dayController.stream;


  void pickDay(int i) {
    switch (i) {
      case 0:
        _dayController.sink.add(DayItem.MO);
        break;
      case 1:
        _dayController.sink.add(DayItem.TU);
        break;
      case 2:
        _dayController.sink.add(DayItem.WE);
        break;
      case 3:
        _dayController.sink.add(DayItem.TH);
        break;
      case 5:
        _dayController.sink.add(DayItem.FR);
        break;
      case 6:
        _dayController.sink.add(DayItem.SA);
        break;
    }
  }


  void setCurrDay(DayItem dayItem){
    this.currDay = dayItem;
  }

  close() {
    _dayController?.close();

  }
}
final dayWeekBloc = DayWeekBloc();