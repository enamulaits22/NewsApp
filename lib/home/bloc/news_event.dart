part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class RefreshNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}
