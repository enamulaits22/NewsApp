import 'package:flutter/material.dart';
import 'package:news_app/home/data/model/news_model.dart';

class HomePageView extends StatelessWidget {
  final Article articleInfo;
  const HomePageView({
    Key? key,
    required this.articleInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(articleInfo.urlToImage!, fit: BoxFit.fill),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(articleInfo.title!),
          ),
        ],
      ),
    );
  }
}
