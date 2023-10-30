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
        shadowColor: Colors.brown,
        color: Colors.brown.shade50,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(widget.article.image),
                  )),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              title: Text(widget.article.name),
              subtitle: Text(widget.article.description),
            ),
            Text(
              "Price: ${widget.article.price} €",
              textAlign: TextAlign.right,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: const BorderSide(width: 4, color: Colors.black),
                      borderRadius: BorderRadius.circular(30.0))),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.brown)),
              child: const Text("Add to Cart"),
              onPressed: () => {},
            )
          ]),
        ));
  }
}
