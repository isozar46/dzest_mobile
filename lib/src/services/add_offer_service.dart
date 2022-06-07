// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dzest_mobile/src/models/add_offer_model.dart';
import 'package:dzest_mobile/src/services/base_api.dart';

import 'package:http/http.dart' as http;

class AddOfferService extends BaseAPI {
  Future<GetOffer> add_offer(String title, String description, int price, String state,
      String municpal, String zipcode, String street_address) async {
    var body = jsonEncode({
      "title": title,
      "description": description,
      "price": price,
      "state": state,
      "municipal": municpal,
      "zip_code": zipcode,
      "street_adress": street_address,
      "owner": 1
    });

    http.Response request = await http.post(
      Uri.parse(super.addOffer + '/'),
      headers: super.headers,
      body: body,
    );
    //if (request.statusCode == 200) {
    var json = request.body;
    return addOfferFromJson(json);
    //}
    //return null;
  }
}
