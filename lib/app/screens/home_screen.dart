import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/articles/articles.dart';
import 'package:webshop_flutter/app/screens/login_screen.dart';
import 'package:webshop_flutter/app/screens/register_screen.dart';
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

    try {
      if (_searchController.text == "") {
        articles = await api.getArticles();
      } else {
        articles = await api.getArticlesSearch(_searchController.text);
      }
      if (mounted) {
        setState(() {});
      }
    } on Exception catch (ex) {
      global.logger.e(ex.toString());
    }
  }

  @override
  void initState() {
    _getArticles();
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
          backgroundColor: Colors.brown,
          title: const Row(
            children: [
              Icon(Icons.shopping_basket, size: 30),
              SizedBox(width: 10),
              Text("WebShop"),
            ],
          ),
          actions: [
            SubmenuButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20))),
              menuChildren: [
                MenuItemButton(
                  child: const MenuAcceleratorLabel('View cart'),
                  onPressed: () => {},
                ),
              ],
              child:
                  const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
            SubmenuButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15))),
              menuChildren: [
                MenuItemButton(
                  child: const MenuAcceleratorLabel('Log in'),
                  onPressed: () => {
                    FocusManager.instance.primaryFocus?.unfocus(),
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
                  },
                ),
                MenuItemButton(
                  child: const MenuAcceleratorLabel('Register'),
                  onPressed: () => {
                    FocusManager.instance.primaryFocus?.unfocus(),
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()))
                  },
                )
              ],
              child:
                  const Icon(Icons.account_box_outlined, color: Colors.white),
            ),
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
                        isRequired: false,
                        onSubmit: (value) => {},
                      ),
                    ),
                    IconButton(
                      onPressed: _getArticles,
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
