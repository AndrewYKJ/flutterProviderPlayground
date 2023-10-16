// ignore_for_file: file_names

import 'package:demo_shopping_riverpod/controller/fav_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favController = ChangeNotifierProvider<FavouriteController>((ref) {
  return FavouriteController();
});

class ProductItem extends ConsumerWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final controller = Provider.of<CartController>(context);
    //  final product = ref.watch(productDataProvider);
    return const SizedBox();
  }
  // final favcontroller = Provider.of<FavouriteController>(context);
  // final proController = Provider.of<ProductController>(context);
  // final products = proController.getProductItems();
  //   final fav = ref.watch(favController);
  //   return product.when(
  //       data: (_data) {
  //         List<ProductElement> products = _data.products!;
  //         return ListView.builder(
  //           itemCount: products.length,
  //           itemBuilder: (context, index) {
  //             final product = products[index];
  //             return ListTile(
  //               title: Text(product.title ?? ''),
  //               subtitle: Text('\$${product.price}'),
  //               trailing: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(
  //                       product.isFavourite!
  //                           ? Icons.favorite
  //                           : Icons.favorite_border,
  //                       color: product.isFavourite! ? Colors.red : null,
  //                     ),
  //                     onPressed: () {
  //                       fav.toggleFavorite(product);
  //                     },
  //                   ),
  //                   IconButton(
  //                     icon: Icon(Icons.add_shopping_cart),
  //                     onPressed: () {
  //                       //controller.addToCart(product);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       },
  //       error: (error, stackTrace) => Text(error.toString()),
  //       loading: () => const Center(
  //             child: CircularProgressIndicator(),
  //           ));
  // }
}
