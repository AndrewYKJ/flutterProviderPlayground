import 'dart:async';

import 'package:badges/badges.dart' as badge;
import 'package:demo_shopping_riverpod/controller/voucher_controller.dart';

import 'package:demo_shopping_riverpod/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product_model.dart';
import '../../providers/providers.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with TickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  final _listmyKey = GlobalKey<AnimatedListState>();
  bool isLoading = true;

  List<ProductElement> products = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              // ignore: unused_local_variable
              final favC = ref.watch(favController);
              final fav = ref.watch(productDataProvider);
              // int count = ref.watch(itemCountProvider);
              return badge.Badge(
                position: badge.BadgePosition.topEnd(top: 5, end: 3),
                badgeAnimation: const badge.BadgeAnimation.slide(
                    // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                    // curve: Curves.easeInCubic,
                    ),
                showBadge: fav.hasValue
                    ? fav.value!.products!
                        .where((element) => element.isFavourite!)
                        .isNotEmpty
                    : false, // favoriteNum > 0,
                badgeStyle: const badge.BadgeStyle(),
                badgeContent: Text(
                  fav.hasValue
                      ? fav.value!.products!
                          .where((element) => element.isFavourite!)
                          .length
                          .toString()
                      : "0",
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                ),
                child: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.favList,
                      );
                    }),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: Consumer(builder: (context, ref, child) {
          final cart = ref.watch(cartController);
          // final cart2 =
          //     ref.watch(cartController2Provider.notifier).numberOfCart;
          return badge.Badge(
            position: badge.BadgePosition.topEnd(top: 6, end: 6),
            badgeAnimation: const badge.BadgeAnimation.slide(
                // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                // curve: Curves.easeInCubic,
                ),
            showBadge: cart.numberOfCart > 0,
            badgeStyle: const badge.BadgeStyle(),
            badgeContent: Text(
              cart.numberOfCart.toString(),
              style: const TextStyle(fontSize: 8, color: Colors.white),
            ),
            child: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cartList);
                }),
          );
        }),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final fav = ref.watch(favController);
          final product = ref.watch(productDataProvider);
          final cart2 = ref.watch(cartController2Provider.notifier);
          final cart = ref.read(cartController.notifier);
          return product.when(
            data: (data) {
              products = data.products!;

              // return ListView.builder(
              //   itemCount: products.length,
              //   itemBuilder: (context, index) {
              //     final product = products[index];
              return SizedBox(
                height: MediaQuery.sizeOf(context).height - kToolbarHeight,
                child: AnimatedList(
                    key: _listmyKey,
                    initialItemCount: products.length,
                    itemBuilder: (context, index, Animation<double> animation) {
                      final product = products[index];
                      return NewWidget(
                        offsetAnimation: animation,
                        product: product,
                        callback: () => remove(index),
                      );
                    }),
                //    );
                //},
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  remove(int index) {
    var item = products[index];

    _listmyKey.currentState!.removeItem(
        index,
        (context, animation) =>
            NewWidget(offsetAnimation: animation, product: item),
        duration: Duration(milliseconds: 250));
    products.removeAt(index);

    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        item.isFavourite!
            ? products.insert(0, item)
            : products.insert(products.length, item);
        _listmyKey.currentState!
            .insertItem(index, duration: Duration(milliseconds: 250));
      });
    });
  }
}

class NewWidget extends ConsumerWidget {
  const NewWidget(
      {super.key,
      required this.offsetAnimation,
      required this.product,
      this.callback});

  final Animation<double> offsetAnimation;
  final VoidCallback? callback;
  final ProductElement product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fav = ref.watch(favController);
    //final cart2 = ref.watch(cartController2Provider.notifier);
    final cart = ref.read(cartController.notifier);
    return SizeTransition(
      sizeFactor: offsetAnimation,
      child: Container(
        // decoration: BoxDecoration(color: Colors.red),
        child: ListTile(
          key: ValueKey(product),
          title: Text(product.title ?? ''),
          subtitle: Text('\$${product.price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  product.isFavourite! ? Icons.favorite : Icons.favorite_border,
                  color: product.isFavourite! ? Colors.red : null,
                ),
                onPressed: () {
                  callback!();
                  fav.toggleFavorite(product);
                  // products
                  //     .sort((a, b) => (b.isFavourite != null
                  //             ? b.isFavourite!
                  //                 ? 1
                  //                 : -1
                  //             : -1)
                  //         .compareTo(a.isFavourite != null
                  //             ? a.isFavourite!
                  //                 ? 1
                  //                 : -1
                  //             : -1));
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // ref
                  //     .watch(
                  //         cartController2Provider.notifier)
                  //     .addProduct(product);
                  cart.addProduct(product);
                  //   cart2.addProduct(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:badges/badges.dart' as badge;
// import 'package:demo_shopping_riverpod/controller/addToCart_controller.dart';
// import 'package:demo_shopping_riverpod/views/product/productList.dart';
// import 'package:demo_shopping_riverpod/views/routes/app_routes.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../controller/fav_Controller.dart';
// import '../controller/product_controller.dart';
// import '../dio/api/getProduct.dart';
// import '../models/product_model.dart';

// // final cartController = Provider<CartController>((ref)=> null;);
// final favController = ChangeNotifierProvider<FavouriteController>((ref) {
//   return FavouriteController();
// });
// final productDataProvider = FutureProvider<Product>((ref) async {
//   return ref.watch(productApiProvider).getProduct();
// });

// class ProductList extends ConsumerWidget {
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final fav = ref.watch(favController);
//     final product = ref.watch(productDataProvider);

//     return product.when(
//         data: (_data) {
//           List<ProductElement> products = _data.products!;

//           return Scaffold(
//             appBar: AppBar(
//               title: Text('E-Commerce App'),
//               actions: [
//                 badge.Badge(
//                   position: badge.BadgePosition.topEnd(top: 5, end: 3),
//                   badgeAnimation: badge.BadgeAnimation.slide(
//                       // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
//                       // curve: Curves.easeInCubic,
//                       ),
//                   showBadge:
//                       products.where((element) => element.isFavourite!).length >
//                           0, // favoriteNum > 0,
//                   badgeStyle: badge.BadgeStyle(),
//                   badgeContent: Text(
//                     products
//                         .where((element) => element.isFavourite!)
//                         .length
//                         .toString(),
//                     style: TextStyle(fontSize: 8, color: Colors.white),
//                   ),
//                   child: IconButton(
//                       icon: Icon(Icons.favorite),
//                       onPressed: () {
//                         Navigator.pushNamed(context, AppRoutes.favList,
//                             arguments: products);
//                       }),
//                 )
//               ],
//             ),
//             floatingActionButton: Container(
//               decoration:
//                   BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//               child: badge.Badge(
//                 position: badge.BadgePosition.topEnd(top: 6, end: 6),
//                 badgeAnimation: badge.BadgeAnimation.slide(
//                     // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
//                     // curve: Curves.easeInCubic,
//                     ),
//                 showBadge: false, //cartNum > 0,
//                 badgeStyle: badge.BadgeStyle(),
//                 badgeContent: Text(
//                   "", // cartNum.toString(),
//                   style: TextStyle(fontSize: 8, color: Colors.white),
//                 ),
//                 child: IconButton(
//                     icon: Icon(Icons.shopping_bag),
//                     onPressed: () {
//                       Navigator.pushNamed(context, AppRoutes.cartList);
//                     }),
//               ),
//             ),
//             body: ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ListTile(
//                   title: Text(product.title ?? ''),
//                   subtitle: Text('\$${product.price}'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           product.isFavourite!
//                               ? Icons.favorite
//                               : Icons.favorite_border,
//                           color: product.isFavourite! ? Colors.red : null,
//                         ),
//                         onPressed: () {
//                           fav.toggleFavorite(product);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add_shopping_cart),
//                         onPressed: () {
//                           //controller.addToCart(product);
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//         error: (error, stackTrace) => Text(error.toString()),
//         loading: () => const Center(
//               child: CircularProgressIndicator(),
//             ));
//   }
// }
