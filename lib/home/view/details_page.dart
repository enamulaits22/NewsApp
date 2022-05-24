import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/db/database_service.dart';
import 'package:news_app/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  // final Article newsDetails;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  const DetailsPage({
    Key? key,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    BlocProvider.of<FavoriteNewsBloc>(context).add(CheckFavoriteNewsEvent(title: widget.title));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isEmptyList = false;
    return BlocBuilder<FavoriteNewsBloc, FavoriteNewsState>(
      builder: (context, state) {
        if (state is CheckFavoriteNewsLoadedState) {
          isEmptyList = state.news.isEmpty;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Details'),
            leading: IconButton(
              onPressed: () {
                BlocProvider.of<FavoriteNewsBloc>(context).add(LoadFavoriteNewsEvent());
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.keyboard_backspace)),
            actions: [
              isEmptyList ? IconButton(
                onPressed: () {
                  DatabaseService.instance.addToNewsArticle(
                    widget.author,
                    widget.title,
                    widget.description,
                    widget.url,
                    widget.urlToImage,
                    widget.publishedAt.toString(),
                    widget.content,
                  );
                  BlocProvider.of<FavoriteNewsBloc>(context).add(CheckFavoriteNewsEvent(title: widget.title));
                },
                icon: const Icon(Icons.favorite_border),
              ) : IconButton(
                onPressed: () {
                  DatabaseService.instance.deleteNewsArticleData(widget.title.toString());
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //   content: Text("Removed from favorite"),
                  // ));
                  BlocProvider.of<FavoriteNewsBloc>(context).add(CheckFavoriteNewsEvent(title: widget.title));
                },
                icon: const Icon(Icons.favorite),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(widget.urlToImage),
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  //   // color: Colors.redAccent,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: widget.urlToImage,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    fit: BoxFit.fill,
                    width: size.width,
                    height: 200.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.author,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(widget.description),
              ],
            ),
          ),
        );
      },
    );
  }
}
