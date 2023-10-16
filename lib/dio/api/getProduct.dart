// ignore_for_file: implementation_imports, file_names

import 'package:dio/dio.dart';

import '../../models/product_model.dart';
import '../dio_repo.dart';

class ProductApi extends DioRepo {
  final DioRepo _dioRepo = DioRepo();
  // ProductApi(BuildContext context) {
  //   dioContext = context;
  // }
  Future<Product> getProduct() async {
    try {
      Response response = await _dioRepo.dio.get('products',
          options: Options(
            contentType: Headers.jsonContentType,
          ));

      final buildingList = (response.data);

      return Product.fromJson(buildingList);
    } catch (e) {
      rethrow;
    }
  }
}
