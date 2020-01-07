import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/providers/cart.dart';
import 'package:provider_pattern/providers/products.dart';
import 'package:provider_pattern/screens/cart_screen.dart';
import 'package:provider_pattern/widgets/app_drawer.dart';
import 'package:provider_pattern/widgets/badge.dart';

import 'package:provider_pattern/widgets/product_grid.dart';

enum FilteredOptions { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavourite = false;
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).getProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("MySHop"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilteredOptions selectedvalue) {
                setState(() {
                  if (selectedvalue == FilteredOptions.favourites) {
                    //   productsContainer.showFavourites();
                    _showOnlyFavourite = true;
                  } else {
                    //    productsContainer.showAll();
                    _showOnlyFavourite = false;
                  }
                  print(selectedvalue);
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favourites'),
                  value: FilteredOptions.favourites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilteredOptions.all,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductGrid(_showOnlyFavourite));
  }
}
