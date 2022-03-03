
class BoxModel {
  BoxModel({
    required this.id,
    required this.description,


  });

  final String id;
  final String description;



  factory BoxModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();




    return BoxModel(
      id: id,
      description: description,


    );

  }
}
