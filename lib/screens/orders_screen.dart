import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/providers/orders.dart';
import 'package:provider_pattern/widgets/app_drawer.dart';
import 'package:provider_pattern/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    var orderContainer = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return OrderItemWidget(orderContainer.orders[index]);
        },
        itemCount: orderContainer.orders.length,
      ),
    );
  }
}
