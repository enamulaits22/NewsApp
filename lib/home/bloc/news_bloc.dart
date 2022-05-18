import 'dart:io';
import 'package:dio/dio.dart';
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

    on<LoadNewsEvent>((event, emit) async => await _mapLoadNewsEventToState(emit));

    on<RefreshNewsEvent>((event, emit) async => await _mapRefreshNewsEventToState(emit));
    
    on<LoadMoreNewsEvent>((event, emit) async => await _mapLoadMoreNewsEventToState(emit));
  }

  Future<void> _mapLoadNewsEventToState(Emitter<NewsState> emit) async{
    emit(NewsLoadingState());
    try {
      final news = await _newsRepository.getNews(emit: emit);
      emit(NewsLoadedState(news: news!));
    } on DioError catch (e) {
      if (e.error is SocketException) {
        emit(NewsErrorState('Please check your internet connection..',));
      }
    }
  }

  Future<void> _mapRefreshNewsEventToState(Emitter<NewsState> emit) async {
    try {
      final news = await _newsRepository.getNews(isRefresh: true, emit: emit);
      emit(NewsRefreshCompleteState());
      emit(NewsLoadedState(news: news!));
    } on DioError catch (e) {
      if (e.error is SocketException) {
        emit(NewsErrorState('Please check your internet connection..',));
      }
    }
  }
  
  Future<void> _mapLoadMoreNewsEventToState(Emitter<NewsState> emit) async {
    try {
      final news = await _newsRepository.getNews(emit: emit);
      emit(NewsLoadMoreCompleteState());
      emit(NewsLoadedState(news: news!));
    } on DioError catch (e) {
      if (e.error is SocketException) {
        emit(NewsErrorState('Please check your internet connection..',));
      }
    }
  }
}