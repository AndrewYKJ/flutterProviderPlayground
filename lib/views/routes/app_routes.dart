import 'package:flutter/material.dart';

import '../cart_page.dart';
import '../fav_page.dart';
import '../product_list.dart';

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
