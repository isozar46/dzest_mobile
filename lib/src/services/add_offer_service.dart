// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:dzest_mobile/src/models/add_offer_model.dart';
import 'package:dzest_mobile/src/services/base_api.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';

import 'package:http/http.dart' as http;

class AddOfferService extends BaseAPI {
  Future<GetOffer> add_offer(String title, String description, int price,
      String state, String municpal, String street_address) async {
    String? token = await getToken();
    headers = {
      ...super.headers,
      HttpHeaders.authorizationHeader: "Token $token",
    };

    var body = jsonEncode({
      "title": title,
      "description": description,
      "price": price,
      "property_area": 443,
      "state": state,
      "municipal": municpal,
      "street_adress": street_address,
      "owner": 1
    });

    http.Response request = await http.post(
      Uri.parse(super.addOffer + '/'),
      headers: headers,
      body: body,
    );
    //if (request.statusCode == 200) {
    var json = request.body;
    return addOfferFromJson(json);
    //}
    //return null;
  }
}
