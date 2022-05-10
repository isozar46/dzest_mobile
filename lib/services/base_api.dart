class BaseAPI {
  static String base = "http://192.168.43.193:8000";
  static var api = base + "/api";
  var offersPath = api + "/offers";
  var authPath = api + "/auth";
  // more routes
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}
