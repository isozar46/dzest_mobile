class BaseAPI {
  static String base = "http://192.168.1.10:8000";
  static var api = base + "/api";
  var offersPath = api + "/test";
  var offerPath = api + "/offer";
  var authPath = api + "/auth";
  var addOffer = api + "/add_offer";
  // more routes
  Map<String, String> headers = {"Content-Type": "application/json; charset=UTF-8"};
}
