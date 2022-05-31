import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:news_app/home/data/model/news_model.dart';
import 'package:news_app/home/data/repository/news_repository.dart';
part 'news_state.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  final NewsRepository _newsRepository;
  NewsNotifier(this._newsRepository) : super(NewsLoadingState());

    List<Article>? news = [];

    Future<void> onLoadNews() async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      state = NewsLoadingState();
      news = await _newsRepository.getNews(state: state);
      state = NewsLoadedState(news: news!);
    } else {
      state = NewsLoadedState(news: news!);
      if (state is NewsLoadedState) {
        state = NewsLoadedState(news: news!, enablePullUp: false);
      }
    }
  }

    Future<void> onRefreshNews() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      news = await _newsRepository.getNews(isRefresh: true, state: state);
      state = NewsRefreshCompleteState();
      state = NewsLoadedState(news: news!);
    } else {
      state = NewsLoadedState(news: news!);
      if (state is NewsLoadedState) {
        state = NewsRefreshCompleteState();
        state = NewsLoadedState(news: news!, enablePullUp: false);
      }
    }
  }
    
    Future<void> onLoadMoreNews() async {
    try {
      final news = await _newsRepository.getNews(state: state);
      state = NewsLoadMoreCompleteState();
      state = NewsLoadedState(news: news!);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        state = NewsErrorState('Please check your internet connection..',);
      }
    }
  }
}

final newsDataProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  final NewsRepository newsRepository = NewsRepository();
  return NewsNotifier(newsRepository);
});
