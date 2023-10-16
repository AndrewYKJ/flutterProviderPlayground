import 'package:demo_shopping_riverpod/controller/voucher_controller.dart';
import 'package:demo_shopping_riverpod/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartItems = ref.watch(cartController);

    final cart2Item = ref.watch(cartController2Provider).cartItems;
    final cartNoC = ref.watch(cartController2Provider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.getCartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems.getCartItems[index];
                return ListTile(
                  title: Text(cartItem.product.title ?? ''),
                  subtitle: cartItems.getPrice(cartItem),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartItems.decreaseQuantity(cartItem);
                        },
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartItems.increaseQuantity(cartItem);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 80,
            child: Consumer(builder: (context, ref, child) {
              final cart2 = ref.watch(cartController2Provider.notifier);
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cart2.vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = cart2.vouchers[index];

                  return Container(
                    width: 343,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(voucher.title),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  voucher.description,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                        ElevatedButton(
                          onPressed: () {
                            cartItems.applyVoucher(voucher);
                          },
                          child: Text(cartItems.selectedVoucher
                                  .any((element) => element.id == voucher.id)
                              ? "Remove"
                              : "Applied"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartItems.calculateTotalAmount().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18.0),
            ),
            ElevatedButton(
              onPressed: () {
                // Place your order logic here
                // This is where you can perform actions like payment processing.
                // You can clear the cart or show a confirmation dialog as needed.
                cartItems.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully!'),
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
