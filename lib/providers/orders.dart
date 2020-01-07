import 'package:flutter/cupertino.dart';
import 'package:provider_pattern/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final String amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double amount) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: amount.toString(),
            dateTime: DateTime.now(),
            products: cartItems));
    notifyListeners();
  }
}
