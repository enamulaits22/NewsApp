part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsLoadingState extends NewsState {
  NewsLoadingState();
  @override
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<Article> news;
  NewsLoadedState(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class NewsRefreshCompleteState extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadMoreCompleteState extends NewsState {
  @override
  List<Object?> get props => [];
}
