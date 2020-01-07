import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/providers/cart.dart';
import 'package:provider_pattern/providers/orders.dart';
import 'package:provider_pattern/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartContainer = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartContainer.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      var orderContainer =
                          Provider.of<Orders>(context, listen: false);
                      orderContainer.addOrder(
                          cartContainer.items.values.toList(),
                          cartContainer.totalAmount);
                      cartContainer.clearCart();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartContainer.items.length,
              itemBuilder: (ctx, i) => CartItemWIdget(
                cartContainer.items.values.toList()[i].id,
                cartContainer.items.values.toList()[i].productId,
                cartContainer.items.values.toList()[i].price,
                cartContainer.items.values.toList()[i].quantity,
                cartContainer.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
