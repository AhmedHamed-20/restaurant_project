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
