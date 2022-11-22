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

class ActiveUserDataGetEvent extends LayoutEvent {
  final String accessToken;
  const ActiveUserDataGetEvent(this.accessToken);

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

class PasswordActiveUserUpdateEvent extends LayoutEvent {
  final String accessToken;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  const PasswordActiveUserUpdateEvent({
    required this.accessToken,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        accessToken,
        oldPassword,
        newPassword,
        confirmPassword,
      ];
}

class AccessTokenUpdateEvent extends LayoutEvent {
  final String accessToken;
  final String key;
  const AccessTokenUpdateEvent({
    required this.accessToken,
    required this.key,
  });

  @override
  List<Object?> get props => [accessToken, key];
}

class AccessTokenGetEvent extends LayoutEvent {
  final String key;

  const AccessTokenGetEvent(this.key);

  @override
  List<Object?> get props => [key];
}
