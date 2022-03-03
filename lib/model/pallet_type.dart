
class PalletModel {
  PalletModel({
    required this.id,
    required this.description,
    required this.weight,


  });

  final String id;
  final String description;
  final String weight;




  factory PalletModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String weight = data['weight'].toString();



    return PalletModel(
      id: id,
      description: description,
      weight: weight,


    );

  }
}
