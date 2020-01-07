import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/providers/product.dart';
import 'package:provider_pattern/providers/products.dart';
import 'package:provider_pattern/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: product);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Are You Sure ?"),
                          content:
                              Text("Please confirm you want to delete product"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            FlatButton(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                                Provider.of<Products>(context, listen: false)
                                    .deleteProduct(product.id);
                              },
                            )
                          ],
                        ));
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
