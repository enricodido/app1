
class CarrierModel {
  CarrierModel({
    required this.id,
    required this.code,
    required this.description,

  });

  final String id;
  final String code;
  final String description;



  factory CarrierModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String code = data['code'].toString();
    final String description = data['description'].toString();



    return CarrierModel(
      id: id,
      code: code,
      description: description,

    );

  }
}
