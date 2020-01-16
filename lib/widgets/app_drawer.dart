import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/helpers/custom_route.dart';
import 'package:provider_pattern/providers/auth.dart';
import 'package:provider_pattern/screens/orders_screen.dart';
import 'package:provider_pattern/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello Dennis"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text("My Orders"),
              onTap: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(OrdersScreen.routeName);
                Navigator.of(context).pushReplacement(
                    CustomRoute(builder: (ctx) => OrdersScreen()));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Product"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
              onTap: () {
                //
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
