class BaseAPI {
  static String base = "http://192.168.1.10:8000";
  static var api = base + "/api";
  var offersPath = api + "/offers";
  var offerPath = api + "/offer";
  var authPath = api + "/auth";
  // more routes
  Map<String, String> headers = {"Content-Type": "application/json; charset=UTF-8"};
}
