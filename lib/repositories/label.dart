import 'dart:convert';

import 'package:agros_app/repositories/repository.dart';

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
}