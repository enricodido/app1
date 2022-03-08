import 'dart:convert';
import 'package:agros_app/repositories/repository.dart';
import '../model/shipment.dart';


class ShipmentRepository {
  late Repository repository;

  ShipmentRepository(this.repository);

  Future<List<Shipment>> get() async {
    final response = await repository.http!.get(
      url: 'get/shippings',);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Shipment> shipments = [];
      data['shippings'].forEach((shipment) {
        shipments.add(Shipment.fromData(shipment));
      });
      return shipments;
    }

    throw RequestError(data);
  }
}