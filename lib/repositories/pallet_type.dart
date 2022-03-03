import 'dart:convert';

import 'package:agros_app/model/boxes_type.dart';
import 'package:agros_app/model/pallet_type.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/label.dart';


class PalletTypeRepository {
  late Repository repository;
  PalletTypeRepository(this.repository);

  Future<List<PalletModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/pallet_types', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<PalletModel> pallet_types = [];
      data['pallet_types'].forEach((pallet_type) {
        pallet_types.add(PalletModel.fromData(pallet_type));
      });
      return pallet_types;
    }

    throw RequestError(data);
  }
}