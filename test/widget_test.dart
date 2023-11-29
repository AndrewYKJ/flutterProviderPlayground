// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:demo_shopping_riverpod/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('0'), findsNothing);
//     expect(find.text('0'), findsNothing);
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:demo_shopping_riverpod/controller/fav_Controller.dart';
import 'package:demo_shopping_riverpod/main.dart';
import 'package:demo_shopping_riverpod/models/product_model.dart';
import 'package:demo_shopping_riverpod/views/product/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('FavouriteController - getFavoriteProducts()', () {
    // Arrange
    final controller = FavouriteController();

    // Act
    final favoriteProducts = controller.getFavoriteProducts();

    // Assert
    expect(favoriteProducts.isEmpty, true);
  });

  test('FavouriteController - numberOfFavorites()', () {
    // Arrange
    final controller = FavouriteController();

    // Act
    final numberOfFavorites = controller.numberOfFavorites();

    // Assert
    expect(numberOfFavorites, 0);
  });

  test('FavouriteController - toggleFavorite()', () {
    // Arrange
    final controller = FavouriteController();
    final product =
        ProductElement(id: 1, title: 'Product 1', isFavourite: false);

    // Act
    controller.toggleFavorite(product);

    // Assert
    expect(product.isFavourite, true);

    controller.toggleFavorite(product);
    expect(product.isFavourite, false);
  });

  test('FavouriteController - removeFromFavorites()', () {
    // Arrange
    final controller = FavouriteController();
    final product =
        ProductElement(id: 1, title: 'Product 1', isFavourite: true);

    // Act
    controller.removeFromFavorites(product);

    // Assert
    expect(product.isFavourite, false);
  });
}
