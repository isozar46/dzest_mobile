import 'package:dzest_mobile/src/models/offer_list.dart';
import 'package:dzest_mobile/src/models/offer.dart';
import 'package:dzest_mobile/src/services/base_api.dart';

import 'package:http/http.dart' as http;

class RemoteService extends BaseAPI {
  Future<OfferList?> getOffers(int page) async {
    var client = http.Client();
    var uri = Uri.parse(offersPath + '?page=$page');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return offersFromJson(json);
    }
    return null;
  }

  Future<Offer?> getOffer(int id) async {
    var client = http.Client();
    var uri = Uri.parse(offerPath + '?id=$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return offerFromJson(json);
    }
    return null;
  }
}
