import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/db/database_service.dart';
import 'package:news_app/core/db/newsdb_model.dart';

part 'fav_news_state.dart';

class FavoriteNewsNotifier extends StateNotifier<FavoriteNewsState> {
  FavoriteNewsNotifier() : super(FavoriteNewsLoadingState());
    
  Future<void> onLoadFavoriteNews() async {
    state = FavoriteNewsLoadingState();
    try {
      final news = await DatabaseService.instance.getNewsArticleData();
      log('loaded db');
      state = FavoriteNewsLoadedState(news: news);
    } catch (e) {
      state = FavoriteNewsErrorState(e.toString());
    }
  }

  Future<void> onCheckFavoriteNews(String title) async {
    try {
      final news = await DatabaseService.instance.checkNewsData(title);
      state = CheckFavoriteNewsLoadedState(news: news);
    } catch (e) {
      state = FavoriteNewsErrorState(e.toString());
    }
  }
}

final favoriteNewsProvider = StateNotifierProvider<FavoriteNewsNotifier, FavoriteNewsState>((ref) {
  return FavoriteNewsNotifier()..onLoadFavoriteNews();
});
