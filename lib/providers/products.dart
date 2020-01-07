import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_pattern/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  bool showFavouritesOnly = false;
  final _baseUrl = "https://providerdemo-29777.firebaseio.com/products.json";

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> getProducts() async {
    try {
      final response = await http.get(_baseUrl);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, product) {
        loadedProducts.add(Product(
            id: prodId,
            description: product['description'],
            imageUrl: product['imageUrl'],
            price: product['price'],
            title: product['title'],
            isFavourite: product['isFavourite']));
      });
      _items = loadedProducts;
      notifyListeners();
      //   print(json.decode(response.body));
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(_baseUrl,
          body: json.encode({
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'title': product.title,
            'isFavourite': product.isFavourite
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title,
          isFavourite: product.isFavourite);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateproduct(String productId, Product newProduct) async {
    final _updatebaseUrl =
        "https://providerdemo-29777.firebaseio.com/products/$productId.json";

    final int productIndex =
        _items.indexWhere((product) => product.id == productId);
    if (productIndex >= 0) {
      try {
        await http.patch(_updatebaseUrl,
            body: json.encode({
              'price': newProduct.price,
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl
            }));
      } catch (error) {
        print(error);
      }
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('product update for $productId failed');
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  Product getProduct(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void showFavourites() {
    showFavouritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    showFavouritesOnly = false;
    notifyListeners();
  }
}