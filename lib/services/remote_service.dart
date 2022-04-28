import '../models/Offer.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Offer>?> getOffers() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.3:8000/api/offers');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return offerFromJson(json);
    }
    return null;
  }
}
