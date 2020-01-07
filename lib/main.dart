import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/providers/cart.dart';
import 'package:provider_pattern/providers/orders.dart';
import 'package:provider_pattern/providers/products.dart';
import 'package:provider_pattern/screens/cart_screen.dart';
import 'package:provider_pattern/screens/edit_product_screen.dart';
import 'package:provider_pattern/screens/orders_screen.dart';
import 'package:provider_pattern/screens/product_details_screen.dart';
import 'package:provider_pattern/screens/products_overview.dart';
import 'package:provider_pattern/screens/user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen()
        },
      ),
    );
  }
}
