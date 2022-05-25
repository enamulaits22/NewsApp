part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteNewsEvent extends Equatable {
  const FavoriteNewsEvent();
}

class LoadFavoriteNewsEvent extends FavoriteNewsEvent {
  @override
  List<Object?> get props => [];
}

class CheckFavoriteNewsEvent extends FavoriteNewsEvent {
  final String title;
  const CheckFavoriteNewsEvent({required this.title});
  @override
  List<Object?> get props => [];
}