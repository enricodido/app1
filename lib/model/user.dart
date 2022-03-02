
class UserModel {
  UserModel({
    required this.id,
    required this.lastname,
    required this.name,
    required this.email,

  });

  final String id;
  final String lastname;
  final String name;
  final String email;



  factory UserModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String lastname = data['lastname'].toString();
    final String name = data['name'].toString();
    final String email = data['email'].toString();



    return UserModel(
        id: id,
        lastname: lastname,
        name: name,
        email: email,

    );

  }
}
