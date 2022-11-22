part of 'layout_bloc.dart';

abstract class LayoutEvent extends Equatable {
  const LayoutEvent();
}

class ChangeCurrentActiveBottomNavIndexEvent extends LayoutEvent {
  final int index;

  const ChangeCurrentActiveBottomNavIndexEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class ActiveUserDataGet extends LayoutEvent {
  final String accessToken;
  const ActiveUserDataGet(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class CurrentIndexAdminPanelChangeEvent extends LayoutEvent {
  final int index;
  const CurrentIndexAdminPanelChangeEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ActiveUserDataUpdateEvent extends LayoutEvent {
  final String accessToken;
  final String name;
  final String email;
  const ActiveUserDataUpdateEvent({
    required this.accessToken,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [accessToken, name, email];
}
