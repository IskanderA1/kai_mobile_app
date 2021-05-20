import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorTabState> {
  NavigatorBloc() : super(null);

  @override
  Stream<NavigatorTabState> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if (event is NavigatorEventSelectTab) {
      yield NavigatorTabState(selectedTab: event.selectTab);
    }
  }
}
