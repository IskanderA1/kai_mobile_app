import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:kai_mobile_app/bloc/profile/profile_bloc.dart';
import 'package:kai_mobile_app/data/api/service/api_events_service.dart';
import 'package:kai_mobile_app/model/application_model.dart';
import 'package:kai_mobile_app/model/event_model.dart';
import 'package:kai_mobile_app/model/member_model.dart';
import 'package:kai_mobile_app/model/rating_list_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc({this.profileBloc}) : super(PortfolioStateLoading());
  final ProfileBloc profileBloc;
  ApiEventsService service = ApiEventsService();

  List<Event> _eventsList;
  List<RatingElements> _ratingList;
  List<Application> _applicationList;
  List<Member> _members;
  String _token;

  String _eventId;
  String _comment;
  String _memberId;

  @override
  Stream<PortfolioState> mapEventToState(
    PortfolioEvent event,
  ) async* {
    if (event is PortfolioEventInit) {
      yield* initializePortfolio();
    } else if (event is PortfolioEventRefreshAll) {
      yield* refreshAllLists();
    } else if (event is PortfolioEventRefreshRating) {
      yield* refreshRatingList();
    } else if (event is PortfolioEventRefreshApplication) {
      yield* refreshApplicationList();
    } else if (event is PortfolioEventSentApplic) {
      yield* _sentEvent(event);
    } else if (event is PortfolioEventCreateProfile) {
      yield* _createPortfolio();
    } else if (event is PortfolioEventOfferEvent) {
      yield* offerEvent(event);
    }
  }

  Stream<PortfolioState> offerEvent(PortfolioEventOfferEvent event) async* {
    String name = event.name;
    String level = event.level;
    String sphere = event.sphere;
    String members = event.members;
    if (name == null ||
        name.isEmpty ||
        level == null ||
        level.isEmpty ||
        sphere == null ||
        sphere.isEmpty) {
      yield PortfolioStateError(error: 'Заполните все поля');
      return;
    }
    var comment =
        "OFFER TO ADD EVENT\nname: $name\nlevel: $level\nsphere: $sphere\nroles: $members";
    bool res;
    try {
      res = await service.offerApplication(_token,
          {'comment': comment, 'raw_event': name, 'raw_memver': members});
      if (res) {
        yield PortfolioStateEventSent();
      }
    } catch (e) {
      yield PortfolioStateError(error: 'Не удалось отправить мероприятие');
    }
    yield* refreshAllLists();
  }

  Stream<PortfolioState> _createPortfolio() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await getToken();
    bool result = false;
    try {
      result = await service.createPortfolio(_token);
    } catch (e) {
      yield PortfolioStateError(error: "Ошибка инициализации");
    }
    prefs.setBool('hasPortfolio', result);
    yield* initializePortfolio();
  }

  Future<bool> _chechPostfolio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool wasCreated = prefs.getBool('hasPortfolio');
      if (wasCreated == null) {
        return false;
      }
      return wasCreated;
    } catch (e) {
      return false;
    }
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (profileBloc.state is ProfileStateAuthorized) {
      _token = prefs.getString("authToken");
    }
  }

  Stream<PortfolioState> initializePortfolio() async* {
    yield PortfolioStateLoading();
    final bool portfolioCreated = await _chechPostfolio();
    if (!portfolioCreated) {
      yield PortfolioStateNeedInit();
      return;
    }
    await getToken();
    if (_token == null || _token.isEmpty) {
      return;
    }
    yield* refreshAllLists();
  }

  Stream<PortfolioState> refreshAllLists() async* {
    yield PortfolioStateLoading();
    if (_token == null || _token.isEmpty) {
      getToken();
    }
    try {
      _eventsList = await service.getEventsList(_token);
      _ratingList = await service.getRating(_token);
      _applicationList = await service.getApplications(_token);
      _members = await service.getMembersList(_token);
    } catch (e) {
      yield PortfolioStateError(error: "Упс, что-то пошло не так...");
    }
    _ratingList.sort((a, b) {
      if (a.total > b.total) {
        return -1;
      } else if (a.total < b.total) {
        return 1;
      } else {
        return a.userId.name.compareTo(b.userId.name);
      }
    });

    List<String> uniqueLevels = List<String>.empty(growable: true);

    List<String> uniqueSpheres = List<String>.empty(growable: true);
    _eventsList.forEach((event) {
      if (!uniqueSpheres.contains(event.sphere)) {
        uniqueSpheres.add(event.sphere);
      }
      if (!uniqueLevels.contains(event.level)) {
        uniqueLevels.add(event.level);
      }
    });

    List<Application> acceptedApps = _applicationList
        .where((element) => element.status == "accepted")
        .toList();
    List<String> acceptedSpheres = List<String>.empty(growable: true);
    acceptedApps.forEach((element) {
      if (!acceptedSpheres.contains(element.event.sphere)) {
        acceptedSpheres.add(element.event.sphere);
      }
    });
    List<GroupApplication> groupApp =
        List<GroupApplication>.empty(growable: true);
    acceptedSpheres.forEach((element) {
      List<Application> list = List<Application>.empty(growable: true);
      int total = 0;
      acceptedApps.forEach((e) {
        if (e.event.sphere == element) {
          list.add(e);
          total += e.ammount;
        }
      });

      groupApp.add(GroupApplication(
          sphere: element, ratingElements: list, total: total));
    });

    yield PortfolioStateLoaded(
        events: _eventsList,
        ratingList: _ratingList,
        applicationsList: _applicationList,
        acceptedApps: acceptedApps,
        grouppedApplication: groupApp,
        uniqueSpheres: uniqueSpheres,
        membersList: _members,
        levelsList: uniqueLevels);
  }

  Stream<PortfolioState> refreshRatingList() async* {
    yield PortfolioStateLoading();
    if (_token == null || _token.isEmpty) {
      getToken();
    }
    try {
      _ratingList = await service.getRating(_token);
    } catch (e) {
      yield PortfolioStateError(error: "Упс, что-то пошло не так...");
    }
    if (_ratingList != null && _ratingList.isNotEmpty) {}
  }

  Stream<PortfolioState> refreshApplicationList() async* {
    yield PortfolioStateLoading();
    if (_token == null || _token.isEmpty) {
      getToken();
    }
    try {
      _applicationList = await service.getApplications(_token);
    } catch (e) {
      yield PortfolioStateError(error: "Упс, что-то пошло не так...");
    }
  }

  Stream<PortfolioState> _sentEvent(PortfolioEventSentApplic event) async* {
    yield PortfolioStateLoading();
    if (event.eventId == null || event.eventId.isEmpty) {
      yield PortfolioStateError(error: "Выберите мероприятие");
      return;
    }
    if (event.memberId == null || event.memberId.isEmpty) {
      yield PortfolioStateError(error: "Выберите роль");
      return;
    }
    if (event.file == null) {
      yield PortfolioStateError(error: "Загрузите скан или фото");
      return;
    }
    bool result = false;
    try {
      result = await service.createApplication(
          _token, event.eventId, event.comment, event.memberId, event.file);
      print("Application sent");
    } catch (e) {
      yield PortfolioStateError(error: "Упс, что-то пошло не так...");
    }
    if (result) {
      yield PortfolioStateAppCreated(
          message: "Достижение успешно отправлено на проверку");
      yield* refreshAllLists();
    }
  }
}
