part of 'news_notifier.dart';

@immutable
abstract class NewsState extends Equatable {}

class NewsLoadingState extends NewsState {
  NewsLoadingState();
  @override
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<Article> news;
  final bool enablePullUp;
  NewsLoadedState({required this.news, this.enablePullUp = true});

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
