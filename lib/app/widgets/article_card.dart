import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/articles/articles.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';
import 'package:webshop_flutter/app/models/cart.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

class ArticleCard extends StatefulWidget {
  final Article article;
  const ArticleCard({super.key, required this.article});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  int _quantity = 1;
  var _counterKey = UniqueKey();

  void _addToCart() {
    for (var item in global.currentCart) {
      if (item.article == widget.article) {
        item.quantity += _quantity;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Item added to cart!"),
          ));
        }
        setState(() {
          _quantity = 1;
          _counterKey = UniqueKey();
        });
        return;
      }
    }

    global.currentCart.add(Cart(article: widget.article, quantity: _quantity));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Item added to cart!"),
      ));
    }
    setState(() {
      _quantity = 1;
      _counterKey = UniqueKey();
    });
  }

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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TouchSpin(
                  key: _counterKey,
                  value: _quantity,
                  textStyle: const TextStyle(fontSize: 18),
                  displayFormat:
                      NumberFormat.decimalPattern(Intl.defaultLocale),
                  onChanged: (value) => _quantity = value.toInt(),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      side: MaterialStateProperty.all(
                          const BorderSide(width: 1, color: Colors.brown)),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.brown)),
                  onPressed: _addToCart,
                  child: const Icon(Icons.add_shopping_cart),
                )
              ],
            )
          ]),
        ));
  }
}
