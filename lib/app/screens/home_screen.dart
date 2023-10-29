import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/articles/articles.dart';
import 'package:webshop_flutter/app/widgets/article_card.dart';
import 'package:webshop_flutter/app/widgets/named_textfield.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Article> articles = [];

  Future _getArticles() async {
    final api = ArticlesApi(global.dio);
    if (_searchController.text == "") {
      articles = await api.getArticles();
    } else {
      articles = await api.getArticlesSearch(_searchController.text);
    }
    setState(() {});
  }

  @override
  void initState() {
    _getArticles();
    _searchController.addListener(() {
      _getArticles();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.shopping_basket, size: 30),
              SizedBox(width: 10),
              Text("WebShop"),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.account_box_outlined)),
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.shopping_cart_outlined))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: NamedTextField(
                        text: "",
                        controller: _searchController,
                        focusNode: FocusNode(),
                        onSubmit: (value) => {},
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.search_outlined),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(article: articles[index]);
                        }))
              ],
            )),
      ),
    );
  }
}
