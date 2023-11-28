// main.dart

import 'package:demo_shopping_riverpod/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      // providers: [
      //   ChangeNotifierProvider(create: (_) => FavouriteController()),
      //   ChangeNotifierProvider(create: (_) => CartController()),
      //   ChangeNotifierProvider(create: (_) => ProductController()),
      // ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generatedRoute,
      initialRoute: AppRoutes.productList,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
