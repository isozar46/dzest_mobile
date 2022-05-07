import 'package:dzest_mobile/models/offer.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Offer>?> getOffers(String query) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.10:8000/api/offers/?q=$query');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return offerFromJson(json);
    }
    return null;
  }
}
