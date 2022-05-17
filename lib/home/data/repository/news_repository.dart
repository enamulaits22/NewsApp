import 'dart:developer';
import 'package:news_app/config/utils/constants.dart';
import 'package:news_app/core/di/dependency_injection.dart';
import 'package:news_app/core/network/http_client.dart';
import 'package:news_app/home/bloc/news_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/home/data/model/news_model.dart';


class NewsRepository {
  int currentgPage = 1;
  List<Article>? articles = [];
  int totalPages = 10;
  BaseHttpClient baseClient = sl.get<BaseHttpClient>();

  Future<List<Article>?> getNews({bool isRefresh = false, required Emitter<NewsState> emit}) async {
    if (isRefresh) {
      currentgPage = 1;
    } else {
      if (currentgPage >= totalPages) {
        emit(NewsLoadMoreCompleteState());
      }
    }
    
    String url = "${Constants.baseUrl}/everything?q=bitcoin&page=$currentgPage&pageSize=10&apiKey=${Constants.apiKey}";
    log(url);
    final response = await baseClient.client.get(url);
    if (response.statusCode == 200) {
      final result = newsModelFromJson(response.data);
      if (isRefresh) {
        articles = result.articles!;
      } else {
        articles!.addAll(result.articles!);
      }
      currentgPage++;
      // totalPages = 10;
      return articles;
    } else {
      throw Exception("Failed to load news");
    }
  }
}