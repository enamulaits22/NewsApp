import 'package:flutter/material.dart';
import 'package:news_app/home/view/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/favorite/bloc/favorite_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    BlocProvider.of<FavoriteNewsBloc>(context).add(LoadFavoriteNewsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<FavoriteNewsBloc, FavoriteNewsState>(
          builder: (context, state) {
            if (state is FavoriteNewsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoriteNewsLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  return HomePageView(
                    title: state.news[index].title!,
                    imageUrl: state.news[index].urlToImage!,
                  );
                },
              );
            }
            if(state is FavoriteNewsErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
