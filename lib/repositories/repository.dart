

import 'dart:io';
import 'package:agros_app/repositories/boxes.dart';
import 'package:agros_app/repositories/customer.dart';
import 'package:agros_app/repositories/pallet_type.dart';
import 'package:agros_app/repositories/product.dart';
import 'package:agros_app/repositories/session.dart';
import 'package:agros_app/repositories/shipment.dart';
import 'package:agros_app/repositories/team.dart';
import 'package:agros_app/repositories/user.dart';
import 'package:http/http.dart' as http;

import 'carrier.dart';
import 'label.dart';


//const String HOST = 'https://checklist.deltacall.it/api/';
const String HOST = 'http://192.168.1.94:8080/api/';

class Repository {
  Repository() {
    http = HttpClient(this);
    userRepository = UserRepository(this);
    sessionRepository = SessionRepository(this);
    labelRepository = LabelRepository(this);
    boxesRepository = BoxesRepository(this);
    customerRepository  = CustomerRepository(this);
    teamRepository = TeamRepository(this);
    palletRepository = PalletTypeRepository(this);
    productRepository = ProductRepository(this);
    shipmentRepository = ShipmentRepository(this);
    carrierRepository = CarrierRepository(this);
  }

  HttpClient? http;
  UserRepository? userRepository;
  SessionRepository? sessionRepository;
  LabelRepository? labelRepository;
  BoxesRepository? boxesRepository;
  CustomerRepository? customerRepository;
  TeamRepository? teamRepository;
  PalletTypeRepository? palletRepository;
  ProductRepository? productRepository;
  ShipmentRepository? shipmentRepository;
  CarrierRepository? carrierRepository;
}

class HttpClient {
  HttpClient(this.repository) {
    client = http.Client();
  }
  final Repository repository;
  http.Client? client;

  Map<String, String> headers() {
    if (repository.sessionRepository!.isLogged()) {
      return {"Authorization": "Bearer ${repository.sessionRepository!.token}"};
    } else {
      return {};
    }
  }

  Future<http.Response> get({
    required String url,
    Map? queryParameters,
  }) {
    return http.get(
      Uri.parse(HOST + url),
      headers: headers(),
    );
  }


  Future<http.Response> post({
    required String url,
    Map bodyParameters = const {},
  })  {
    return http.post(
      Uri.parse(HOST + url),
      body: bodyParameters,
      headers: headers(),
    );
  }

  Future<http.Response> postMultipart({
    required String url,
    Map bodyParameters = const {},
    Map<String, File> fileParameters = const {},
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(HOST + url),
    );

    request.headers.addAll(headers());

    bodyParameters.forEach((key, value) {
      request.fields[key] = value;
    });

    fileParameters.forEach((key, file) async {
      var requestFile = await http.MultipartFile.fromPath(key, file.path);
      request.files.add(requestFile);
    });

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}

class RequestError {
  final error;
  RequestError(this.error);
}
