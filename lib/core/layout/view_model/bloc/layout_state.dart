part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final int currentIndex;
  final UserModel? activeUser;
  final LayoutRequestStatues layoutRequestStatues;
  final String errorMessage;
  const LayoutState(
      {this.currentIndex = 0,
      this.activeUser,
      this.errorMessage = '',
      this.layoutRequestStatues = LayoutRequestStatues.loading});

  LayoutState copyWith({
    int? currentIndex,
    UserModel? activeUser,
    String? errorMessage,
    LayoutRequestStatues? layoutRequestStatues,
  }) {
    return LayoutState(
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndex: currentIndex ?? this.currentIndex,
      activeUser: activeUser ?? this.activeUser,
      layoutRequestStatues: layoutRequestStatues ?? this.layoutRequestStatues,
    );
  }

  @override
  List<Object?> get props =>
      [currentIndex, errorMessage, activeUser, layoutRequestStatues];
}
