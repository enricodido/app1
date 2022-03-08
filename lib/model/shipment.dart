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
  final String carrier;
  final String vehicle;
  final String note;
  final String status;
  final CustomerModel customer;




  factory Shipment.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String carrier = data['carrier_id'].toString();
    final String progressive = data['progressive'].toString();
    final String date = data['date'].toString();
    final String vehicle = data['vehicle'].toString();
    final String note = data['note'].toString();
    final String status = data['status'].toString();
    final CustomerModel customer = CustomerModel.fromData(data['customer']);
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
