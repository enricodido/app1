import 'package:agros_app/model/carriers.dart';
import 'package:agros_app/model/shipment.dart';
import 'package:intl/intl.dart';

import 'customers.dart';
import 'label.dart';

class ShipmentDetail {
  ShipmentDetail({
    required this.id,
    required this.shipment,
    required this.label,
   


  });

  final String id;
  final Shipment shipment;
  final Label label;



  factory ShipmentDetail.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    
    final Shipment shipment = Shipment.fromData(data['shipment']);
    final Label label = Label.fromData(data['label']);
   




    return ShipmentDetail(
      id: id,
      label: label,
      shipment: shipment,
      


    );

  }
}
