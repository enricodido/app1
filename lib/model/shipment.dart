import 'package:agros_app/model/carriers.dart';
import 'package:intl/intl.dart';

import 'customers.dart';

class Shipment {
  Shipment({
    required this.id,
    required this.progressive,
    required this.date,
    required this.carrier,
    required this.customer,
    required this.note,
    required this.vehicle,
    required this.status,


  });

  final String id;
  final String progressive;
  final String date;

  final String vehicle;
  final String note;
  final String status;
  final CustomerModel customer;
  final CarrierModel carrier;



  factory Shipment.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String progressive = data['progressive'].toString();
    final String date = DateFormat('dd/MM/yyyy HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['date'].toString()));
    final String vehicle = data['vehicle'].toString();
    final String note = data['note'].toString();
    final String status = data['status'].toString();
    final CustomerModel customer = CustomerModel.fromData(data['customer']);
    final CarrierModel carrier = CarrierModel.fromData(data['carrier']);
    //  final PalletModel pallet = PalletModel.fromData(data['pallet_type']);
    //  final BoxModel box = BoxModel.fromData(data['boxes_tipe']);
    //  final CustomerModel customer = CustomerModel.fromData(data['customer']);



    return Shipment(
      id: id,
      progressive: progressive,
      date: date,
      note: note,
      carrier: carrier,
      customer: customer,
      vehicle: vehicle,
      status: status,
      //  pallet: pallet,
      //  box: box,
      //  customer: customer,


    );

  }
}
