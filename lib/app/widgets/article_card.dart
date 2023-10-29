import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/articles/articles.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  const ArticleCard({super.key, required this.article});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        ListTile(
          leading: Image(image: NetworkImage(widget.article.image)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Text(widget.article.name),
          subtitle: Text(widget.article.description),
        ),
        OutlinedButton(
          child: const Text("Add to Cart"),
          onPressed: () => {},
        )
      ]),
    ));
  }
}
