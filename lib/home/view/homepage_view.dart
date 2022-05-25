import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  const HomePageView({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            // child: Image.network(imageUrl!, fit: BoxFit.fill),
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title!),
          ),
        ],
      ),
    );
  }
}
