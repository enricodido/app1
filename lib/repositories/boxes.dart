import 'dart:convert';

import 'package:agros_app/model/boxes_type.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/label.dart';


class BoxesRepository {
  late Repository repository;
  BoxesRepository(this.repository);

  Future<List<BoxModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/boxes_types', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<BoxModel> boxes = [];
      data['boxes_tipes'].forEach((box) {
        boxes.add(BoxModel.fromData(box));
      });
      return boxes ;
    }

    throw RequestError(data);
  }
}