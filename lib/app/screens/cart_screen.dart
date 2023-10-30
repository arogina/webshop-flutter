import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/models/cart.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;
import 'package:webshop_flutter/app/widgets/named_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            ),
            body: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your cart:",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DataTable(
                      columnSpacing: 10,
                      columns: const [
                        DataColumn(
                            label: SizedBox(
                          width: 100,
                          child: Text("Article"),
                        )),
                        DataColumn(label: Text("Qty.")),
                        DataColumn(label: Text("Price")),
                        DataColumn(label: Text("")),
                      ],
                      rows: global.currentCart.map((item) {
                        return DataRow(cells: [
                          DataCell(SizedBox(
                              width: 150, child: Text(item.article.name))),
                          DataCell(Text(item.quantity.toString())),
                          DataCell(Text(item.article.price)),
                          DataCell(IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              global.currentCart.remove(item);
                              setState(() {});
                            },
                          )),
                        ]);
                      }).toList()),
                  const Divider(thickness: 3),
                  Text(
                    "TOTAL: ${Cart.totalSum}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(thickness: 3),
                  NamedButton(text: "Checkout", onClick: () => {}),
                  NamedButton(
                      text: "Clear",
                      backgroundColor: Colors.red.shade300,
                      onClick: () => {
                            global.currentCart = [],
                            Cart.totalSum = 0,
                            setState(() {})
                          })
                ]))));
  }
}
