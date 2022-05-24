import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/home/data/model/news_model.dart';
import 'package:news_app/home/data/repository/news_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends HydratedBloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsLoadingState()) {

    on<LoadNewsEvent>((event, emit) async => await _mapLoadNewsEventToState(emit, state));

    on<RefreshNewsEvent>((event, emit) async => await _mapRefreshNewsEventToState(emit, state));
    
    on<LoadMoreNewsEvent>((event, emit) async => await _mapLoadMoreNewsEventToState(emit));
  }

  Future<void> _mapLoadNewsEventToState(Emitter<NewsState> emit, NewsState state) async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      emit(NewsLoadingState());
      final news = await _newsRepository.getNews(emit: emit);
      emit(NewsLoadedState(news: news!));
    } else {
      emit(NewsLoadedState(news: const[]));
      if (state is NewsLoadedState) {
        emit(NewsLoadedState(news: state.news, enablePullUp: false));
      }
    }
  }

  Future<void> _mapRefreshNewsEventToState(Emitter<NewsState> emit, NewsState state) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      final news = await _newsRepository.getNews(isRefresh: true, emit: emit);
      emit(NewsRefreshCompleteState());
      emit(NewsLoadedState(news: news!));
    } else {
      emit(NewsLoadedState(news: const[]));
      if (state is NewsLoadedState) {
        emit(NewsRefreshCompleteState());
        emit(NewsLoadedState(news: state.news, enablePullUp: false));
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
  
  @override
  NewsLoadedState? fromJson(Map<String, dynamic> json) {
    // return NewsLoadedState(news: json['article'] as List<Article>);
    return NewsLoadedState(news: NewsModel.fromJson(json).articles!);
  }
  
  @override
  Map<String, dynamic>? toJson(NewsState state) {
    if(state is NewsLoadedState) {
      return {
        "status": 'status',
        "totalResults": 0,
        "articles": List<dynamic>.from(state.news.map((x) => x.toJson())),
      };
    }
    return null;
  }
  
  // @override
  // NewsState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final news = NewsModel.fromJson(json);
  //     return NewsLoadedState(news: news.articles!);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(NewsState state) {
  //   if (state is NewsLoadedState) {
  //     return {'article': state.news};
  //   } else {
  //     return null;
  //   }
  // }
}