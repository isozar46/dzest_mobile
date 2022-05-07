import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.10:8000/api/offer/?q=$query');
    var response = await client.get(uri);
    print("search_service.dart: searchDjangoApi: ${response.body}");
    return response.body;
  }
}
