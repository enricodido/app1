import 'package:agros_app/model/pallet_type.dart';
import 'package:agros_app/model/product.dart';
import 'package:agros_app/model/team.dart';
import 'package:intl/intl.dart';

import 'boxes_type.dart';
import 'customers.dart';

class Label {
  Label({
    required this.id,
    required this.batch,
    required this.progressive,
    required this.date,
    this.total_weight,
    this.weight,
    required this.product,
    required this.team,
    required this.number,
    this.note,
    required this.pallet,
    required this.box,
    required this.customer,

  });

  final String id;
  final String? batch;
  final String? progressive;
  final String date;
  final String? total_weight;
  final String? weight;
  final String number;
  final String? note;
  final ProductModel product;
  final TeamModel team;
  final PalletModel pallet;
  final BoxModel box;
  final CustomerModel customer;



  factory Label.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String? batch = data['batch'].toString();
    final String? progressive = data['progressive'].toString();
    final String date = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(data['date'].toString()));
    String total_weight = '';
    if(data['total_weight'] != null) {
      total_weight = data['total_weight'].toString();
    }
    String note = '';
    if(data['note'] != null) {
      note = data['note'].toString();
    }
    String weight = '';
    if(data['weight'] != null) {
      weight = data['weight'].toString();
    }
    
    final String number = data['numbers'].toString();
    final ProductModel product = ProductModel.fromData(data['product']);
    final TeamModel team = TeamModel.fromData(data['team']);
    final PalletModel pallet = PalletModel.fromData(data['pallet_type']);
    final BoxModel box = BoxModel.fromData(data['boxes_type']);
    final CustomerModel customer = CustomerModel.fromData(data['customer']);



    return Label(
      id: id,
      batch: batch,
      progressive: progressive,
      date: date,
      total_weight: total_weight,
      weight: weight,
      product: product,
      team: team,
      number: number,
      note: note,
      pallet: pallet,
      box: box,
      customer: customer,


    );

  }
}
