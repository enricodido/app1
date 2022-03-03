
class ProductModel {
  ProductModel({
    required this.id,
    required this.code,
    required this.description,
    required this.variety,

  });

  final String id;
  final String code;
  final String description;
  final String variety;



  factory ProductModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String code = data['code'].toString();
    final String description = data['description'].toString();
    final String variety = data['variety'].toString();



    return ProductModel(
      id: id,
      code: code,
      description: description,
      variety: variety,

    );

  }
}
