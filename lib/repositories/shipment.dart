import 'dart:convert';
import 'package:agros_app/repositories/repository.dart';
import '../model/shipment.dart';
import '../model/shipment_detail.dart';


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

  Future<List<ShipmentDetail>> getDetail({required String shipment_id}) async {
    final response = await repository.http!.get(
      url: 'get/detail/shippings/' + shipment_id );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<ShipmentDetail> shipping_details = [];
      data['shipping_details'].forEach((shipping_detail) {
        shipping_details.add(ShipmentDetail.fromData(shipping_detail));
      });
      return shipping_details;
    }

    throw RequestError(data);
  }


  Future<bool> change({required String shipment_id, String? slot}) async {
    final response = await repository.http!.post(
      url: 'change/shippings/' + shipment_id ,
      bodyParameters: {
      'slot': slot,
    
    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return true;
    } else {

      return false;
    }
  }


  Future<bool> record(
      context,
      String carrier_id ,
      String customer_id,
      String date,
      String vehicle,
      String note,


      ) async {
    final response =
    await repository.http!.post(
        url: 'record/shippings', bodyParameters: {
      'carrier_id': carrier_id,
      'customer_id': customer_id,
      'date': date,
      'vehicle': vehicle,
      'note': note,
      
    });
    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return true;
    } else {

      return false;
    }
  }

Future<bool> detail(
      context,
      String shipment_id,
      String note ,
      


      ) async {
    final response =
    await repository.http!.post(
        url: 'detail/shipping', bodyParameters: {
      'shipping_id' : shipment_id,
      'labeling_and_loading_id': note,
    });
    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return true;
    } else {

      return false;
    }
  }

Future<bool> update(
      context,
      String shipment_id,
      String carrier_id ,
      String customer_id,
      String date,
      String vehicle,
      String note,
      ) async {
    final response =
    await repository.http!.post(
        url: 'update/shippings/' + shipment_id, bodyParameters: {
      'carrier_id': carrier_id,
      'customer_id': customer_id,
      'date': date,
      'vehicle': vehicle,
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