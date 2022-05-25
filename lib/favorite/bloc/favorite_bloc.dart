import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/db/database_service.dart';
import 'package:news_app/core/db/newsdb_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteNewsBloc extends Bloc<FavoriteNewsEvent, FavoriteNewsState> {
  FavoriteNewsBloc() : super(FavoriteNewsLoadingState()) {
    
    on<LoadFavoriteNewsEvent>((event, emit) async {
      emit(FavoriteNewsLoadingState());
      try {
        final news = await DatabaseService.instance.getNewsArticleData();
        emit(FavoriteNewsLoadedState(news: news));
      } catch (e) {
        emit(FavoriteNewsErrorState(e.toString()));
      }
    });

    on<CheckFavoriteNewsEvent>((event, emit) async {
      try {
        final news = await DatabaseService.instance.checkNewsData(event.title);
        emit(CheckFavoriteNewsLoadedState(news: news));
      } catch (e) {
        emit(FavoriteNewsErrorState(e.toString()));
      }
    });
  }
}
