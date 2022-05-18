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
            child: Image.network(imageUrl!, fit: BoxFit.fill),
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
