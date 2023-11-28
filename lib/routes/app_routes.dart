import 'package:demo_shopping_riverpod/views/cart_page.dart';
import 'package:flutter/material.dart';

import '../views/fav_page.dart';
import '../views/product/product_list.dart';

class AppRoutes {
  static const String productList = "productList";

  static const String cartList = "cartList";

  static const String favList = "favList";

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case productList:
        return MaterialPageRoute(builder: (_) => ProductList());
      case favList:
        return MaterialPageRoute(builder: (_) => FavoriteProductsPage());
      case cartList:
        return MaterialPageRoute(builder: (_) => CartPage());
      default:
        return MaterialPageRoute(builder: (_) => ProductList());
    }
  }
}
