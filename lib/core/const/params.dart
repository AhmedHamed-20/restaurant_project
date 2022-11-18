import 'package:equatable/equatable.dart';

class FavouriteScreenParams extends Equatable {
  final String accessToken;
  final String userId;

  const FavouriteScreenParams(this.accessToken, this.userId);

  @override
  List<Object?> get props => [accessToken, userId];
}
