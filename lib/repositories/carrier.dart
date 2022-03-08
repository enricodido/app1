import 'dart:convert';

import 'package:agros_app/model/customers.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/carrier.dart';
import '../model/label.dart';


class CarrierRepository {
  late Repository repository;

  CarrierRepository(this.repository);


  Future<List<CarrierModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/carriers',);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<CarrierModel> carriers = [];
      data['carriers'].forEach((carrier) {
        carriers.add(CarrierModel.fromData(carrier));
      });
      return carriers;
    }

    throw RequestError(data);
  }
}