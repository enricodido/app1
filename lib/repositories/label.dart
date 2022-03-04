import 'dart:convert';

import 'package:agros_app/repositories/repository.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/label.dart';


class LabelRepository {
  late Repository repository;
  LabelRepository(this.repository);

  Future<List<Label>> get() async {
    final response = await repository.http!.get(
      url: 'get/labeling_and_loadings', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Label> labels = [];
      data['labeling_and_loadings'].forEach((label) {
        labels.add(Label.fromData(label));
      });
      return labels;
    }

    throw RequestError(data);
  }

  Future<String> create() async {
    final response = await repository.http!.get(
      url: 'create/labeling_and_loadings', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {

      return data['progressive'].toString();
    }

    throw RequestError(data);
  }

  Future<String?> recordProduct(context, String product_id, String label_id) async {
    final response = await repository.http!.post(
      url: 'record/product/labeling_and_loadings',  bodyParameters: {
      'product_id': product_id,
      'labeling_and_loading_id': label_id,
    });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {

      return data['labeling_and_loading_id'].toString();
    }

    throw RequestError(data);
  }
}