import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/home/view/details_page.dart';
import 'package:news_app/home/view/homepage_view.dart';
import 'package:news_app/favorite/fav_news_provider/fav_news_notifier.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer(
          builder: (context, ref, child) {
            FavoriteNewsState state = ref.watch(favoriteNewsProvider);
            if (state is FavoriteNewsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoriteNewsLoadedState) {
              return state.news.isEmpty
              ? const Center(child: Text('No News found!'))
              : ListView.builder(
                shrinkWrap: true,
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  var newsInfo = state.news[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            author: newsInfo.author!,
                            title: newsInfo.title!,
                            description: newsInfo.description!,
                            url: newsInfo.url!,
                            urlToImage: newsInfo.urlToImage!,
                            publishedAt: newsInfo.publishedAt.toString(),
                            content: newsInfo.content!,
                          ),
                        ),
                      );
                    },
                    child: HomePageView(
                      title: newsInfo.title!,
                      imageUrl: newsInfo.urlToImage!,
                    ),
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
