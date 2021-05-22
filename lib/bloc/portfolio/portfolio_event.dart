part of 'portfolio_bloc.dart';

enum PortfMenuItems {
  Preview,
  NewAchiev,
  ActivityAdding,
  GlobalRating,
  Menu,
  Profile
}

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object> get props => [];
}

class PortfolioEventInit extends PortfolioEvent {}

class PortfolioEventRefreshAll extends PortfolioEvent {}

class PortfolioEventRefreshRating extends PortfolioEvent {}

class PortfolioEventRefreshApplication extends PortfolioEvent {}

class PortfolioEventCreateProfile extends PortfolioEvent {}

class PortfolioEventSentApplic extends PortfolioEvent {
  final String eventId;
  final String memberId;
  final String comment;
  final File file;

  PortfolioEventSentApplic(
      {@required this.eventId,
      @required this.memberId,
      @required this.comment,
      @required this.file});

  @override
  List<Object> get props => [file, eventId, memberId, comment];
}

class PortfolioEventOfferEvent extends PortfolioEvent {
  final String name;
  final String sphere;
  final String level;
  final String members;
  final String link;

  PortfolioEventOfferEvent(
      {this.name, this.level, this.sphere, this.members, this.link});
  @override
  List<Object> get props => [name, level, sphere];
}
