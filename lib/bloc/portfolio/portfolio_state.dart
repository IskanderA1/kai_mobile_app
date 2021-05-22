part of 'portfolio_bloc.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object> get props => [];
}

class PortfolioStateNeedInit extends PortfolioState {
  PortfolioStateNeedInit();

  @override
  List<Object> get props => [];

  @override
  String toString() => "PortfolioStateNeedInit";
}

class PortfolioStateLoading extends PortfolioState {
  PortfolioStateLoading();

  @override
  List<Object> get props => [];

  @override
  String toString() => "PortfolioStateLoading";
}

class PortfolioStateLoaded extends PortfolioState {
  final List<Event> events;
  final List<RatingElements> ratingList;
  final List<Application> applicationsList;
  final List<Application> acceptedApps;
  final List<GroupApplication> grouppedApplication;
  final List<String> uniqueSpheres;
  final List<Member> membersList;
  final List<String> levelsList;
  final int totalUserScore;
  final int scoresInConsider;

  PortfolioStateLoaded(
      {@required this.events,
      @required this.ratingList,
      @required this.applicationsList,
      @required this.acceptedApps,
      @required this.grouppedApplication,
      @required this.uniqueSpheres,
      @required this.membersList,
      @required this.levelsList,
      @required this.totalUserScore,
      @required this.scoresInConsider});

  @override
  List<Object> get props => [events, ratingList];

  @override
  String toString() => "PortfolioStateLoaded";
}

class PortfolioStateError extends PortfolioState {
  final String error;

  PortfolioStateError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "PortfolioStateError";
}

class PortfolioStateAppCreated extends PortfolioState {
  final String message;

  PortfolioStateAppCreated({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "PortfolioStateAppCreated";
}

class PortfolioStateEventSent extends PortfolioState {
  PortfolioStateEventSent();

  @override
  List<Object> get props => [];

  @override
  String toString() => "PortfolioStateEventSent";
}
