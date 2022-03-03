import 'dart:convert';

import 'package:agros_app/model/boxes_type.dart';
import 'package:agros_app/model/product.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/label.dart';


class ProductRepository {
  late Repository repository;
  ProductRepository(this.repository);

  Future<List<ProductModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/products', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<ProductModel> products = [];
      data['products'].forEach((product) {
        products.add(ProductModel.fromData(product));
      });
      return products;
    }

    throw RequestError(data);
  }
}