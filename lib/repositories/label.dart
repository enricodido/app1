import 'dart:convert';

import 'package:agros_app/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

import '../components/customDialog.dart';
import '../model/label.dart';


class LabelRepository {
  late Repository repository;
  LabelRepository(this.repository);

  Future<List<Label>> get() async {
    final response = await repository.http!.get(
      url: 'get/labeling_and_loadings' );
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

  Future<bool> record(
      context,
     String product_id ,
     String pallet_type_id,
     String date,
     String batch,
     String weight,
     String numbers,
     String property_id,
      String note,
     String boxes_type_id,
     String team_id,

  ) async {
    final response =
    await repository.http!.post(
        url: 'record/labeling_and_loadings', bodyParameters: {
      'product_id': product_id,
      'pallet_type_id': pallet_type_id,
      'date': date,
      'batch': batch,
      'total_weight': weight,
      'property_id': property_id,
      'boxes_type_id': boxes_type_id,
      'team_id': team_id,
      'numbers': numbers,
      'note': note,
    });
    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return true;
    } else {

      return false;
    }
  }
}