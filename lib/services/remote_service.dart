import 'package:dzest_mobile/models/offer.dart';
import 'package:dzest_mobile/services/base_api.dart';

import 'package:http/http.dart' as http;

class RemoteService extends BaseAPI {
  Future<List<Offer>?> getOffers(String query) async {
    var client = http.Client();
    var uri = Uri.parse(offersPath + '?q=$query');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return offerFromJson(json);
    }
    return null;
  }
}
