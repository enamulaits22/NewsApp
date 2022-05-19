import 'package:flutter/material.dart';
import 'package:news_app/core/db/database_service.dart';
import 'package:news_app/favorite/bloc/favorite_bloc.dart';
import 'package:news_app/home/data/model/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  final Article newsDetails;
  const DetailsPage({Key? key, required this.newsDetails}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    BlocProvider.of<FavoriteNewsBloc>(context).add(CheckFavoriteNewsEvent(title: widget.newsDetails.title!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isEmptyList = false;
    return BlocBuilder<FavoriteNewsBloc, FavoriteNewsState>(
      builder: (context, state) {
        if(state is CheckFavoriteNewsLoadedState){
          isEmptyList = state.news.isEmpty;
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('News Details'),
              actions: [
                isEmptyList ? IconButton(
                  onPressed: () {
                    DatabaseService.instance.addToNewsArticle(
                      widget.newsDetails.author!,
                      widget.newsDetails.title!,
                      widget.newsDetails.description!,
                      widget.newsDetails.url!,
                      widget.newsDetails.urlToImage!,
                      widget.newsDetails.publishedAt.toString(),
                      widget.newsDetails.content!,
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                ) : IconButton(
                  onPressed: () {
                    DatabaseService.instance.deleteNewsArticleData(widget.newsDetails.title.toString());
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
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg', fit: BoxFit.cover,),
                  // ),
                  Container(
                    width: size.width,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.newsDetails.urlToImage!),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      // color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.newsDetails.author!,
                      style: const TextStyle(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 8),
                  Text(widget.newsDetails.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(widget.newsDetails.description!),
                ],
              ),
            ));
      },
    );
  }
}
