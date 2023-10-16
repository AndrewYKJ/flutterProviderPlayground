import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class FavoriteProductsPage extends ConsumerWidget {
  const FavoriteProductsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // // final controller = Provider.of<FavouriteController>(context);
    // data.forEach(
    //   (element) {
    //     element.isFavourite! ? print(element.title) : null;
    //   },
    // );
    final fav = ref.watch(favController);
    final products = ref.watch(productDataProvider);
    final favProduct = products.asData!.value.products!
        .where((element) => element.isFavourite!)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favProduct.length,
        itemBuilder: (context, index) {
          final product = favProduct[index];
          return ListTile(
            title: Text(product.title ?? ''),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                fav.removeFromFavorites(product);
              },
            ),
          );
        },
      ),
    );
  }
}
