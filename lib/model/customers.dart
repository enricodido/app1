
class CustomerModel {
  CustomerModel({
    required this.id,
    required this.customer_code,
    required this.business_name,
    required this.address,

  });

  final String id;
  final String customer_code;
  final String business_name;
  final String address;



  factory CustomerModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String business_name = data['business_name'].toString();
    final String customer_code = data['customer_code'].toString();
    final String address = data['address'].toString();



    return CustomerModel(
      id: id,
      customer_code: customer_code,
      business_name: business_name,
      address: address,

    );

  }
}
