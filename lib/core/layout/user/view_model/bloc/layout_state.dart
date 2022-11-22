part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final int currentIndex;
  final int currentIndexAdminPanel;
  final UserModel? activeUser;
  final LayoutRequestStatues layoutRequestStatues;
  final String errorMessage;
  final ActiveUserUpdateDataRequestStatues activeUserUpdateDataRequestStatues;
  const LayoutState(
      {this.currentIndex = 0,
      this.activeUser,
      this.activeUserUpdateDataRequestStatues =
          ActiveUserUpdateDataRequestStatues.idle,
      this.currentIndexAdminPanel = 0,
      this.errorMessage = '',
      this.layoutRequestStatues = LayoutRequestStatues.loading});

  LayoutState copyWith({
    int? currentIndex,
    ActiveUserUpdateDataRequestStatues? activeUserUpdateDataRequestStatues,
    UserModel? activeUser,
    String? errorMessage,
    int? currentIndexAdminPanel,
    LayoutRequestStatues? layoutRequestStatues,
  }) {
    return LayoutState(
      activeUserUpdateDataRequestStatues: activeUserUpdateDataRequestStatues ??
          this.activeUserUpdateDataRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndexAdminPanel:
          currentIndexAdminPanel ?? this.currentIndexAdminPanel,
      currentIndex: currentIndex ?? this.currentIndex,
      activeUser: activeUser ?? this.activeUser,
      layoutRequestStatues: layoutRequestStatues ?? this.layoutRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        errorMessage,
        activeUser,
        layoutRequestStatues,
        currentIndexAdminPanel,
        activeUserUpdateDataRequestStatues,
      ];
}
