part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteNewsState extends Equatable{}

class FavoriteNewsLoadingState extends FavoriteNewsState {
  FavoriteNewsLoadingState();
  @override
  List<Object?> get props => [];
}

class FavoriteNewsLoadedState extends FavoriteNewsState {
  final List<NewsDbModel> news;
  FavoriteNewsLoadedState({required this.news});

  @override
  List<Object?> get props => [news];
}

class FavoriteNewsErrorState extends FavoriteNewsState {
  final String error;
  FavoriteNewsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CheckFavoriteNewsLoadedState extends FavoriteNewsState {
  final List<NewsDbModel> news;
  CheckFavoriteNewsLoadedState({required this.news});

  @override
  List<Object?> get props => [news];
}