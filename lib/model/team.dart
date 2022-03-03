
class TeamModel {
  TeamModel({
    required this.id,
    required this.description,
    required this.numbers,

  });

  final String id;
  final String description;
  final String numbers;



  factory TeamModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String numbers = data['numbers'].toString();



    return TeamModel(
      id: id,
      description: description,
      numbers: numbers,

    );

  }
}
