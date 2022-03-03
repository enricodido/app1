import 'dart:convert';

import 'package:agros_app/model/customers.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/label.dart';


class CustomerRepository {
  late Repository repository;

  CustomerRepository(this.repository);


  Future<List<CustomerModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/customers',);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<CustomerModel> customers = [];
      data['customers'].forEach((customer) {
        customers.add(CustomerModel.fromData(customer));
      });
      return customers;
    }

    throw RequestError(data);
  }
}