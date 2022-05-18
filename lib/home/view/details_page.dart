import 'package:flutter/material.dart';
import 'package:news_app/home/data/model/news_model.dart';

class DetailsPage extends StatelessWidget {
  final Article newsDetails;
  const DetailsPage({Key? key, required this.newsDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(title: const Text('News Details')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:  Column(
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
                  image: NetworkImage(newsDetails.urlToImage!),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                // color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(newsDetails.author!, style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Text(newsDetails.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 6),
            Text(newsDetails.description!),
          ],
        ),
      ));
  }
}