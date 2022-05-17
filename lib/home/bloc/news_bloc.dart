import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/home/data/model/news_model.dart';
import 'package:news_app/home/data/repository/news_repository.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsLoadingState()) {

    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await _newsRepository.getNews(emit: emit);
        emit(NewsLoadedState(news!));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });

    on<RefreshNewsEvent>((event, emit) async {
      try {
        final news = await _newsRepository.getNews(isRefresh: true, emit: emit);
        emit(NewsRefreshCompleteState());
        emit(NewsLoadedState(news!));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
    
    on<LoadMoreNewsEvent>((event, emit) async {
      try {
        final news = await _newsRepository.getNews(emit: emit);
        emit(NewsLoadMoreCompleteState());
        emit(NewsLoadedState(news!));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}