import 'package:webshop_flutter/app/api/articles/articles.dart';

class Cart {
  Article article;
  int quantity;
  static double totalSum = 0;

  Cart({
    required this.article,
    required this.quantity,
  }) {
    totalSum += double.parse(article.price) * quantity;
  }
}
