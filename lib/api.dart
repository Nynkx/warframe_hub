import 'dart:convert';

import 'package:http/http.dart' as http;

import 'cetus_cycle.dart';

class APIHelper {
  static APIHelper _apiHelper;

  final String url = "api.warframestat.us";
  final String platform = "pc";

  APIHelper._createInstance();

  static final APIHelper api = APIHelper._createInstance();

  factory APIHelper() {
    if (_apiHelper == null) {
      _apiHelper = APIHelper._createInstance();
    }
    return _apiHelper;
  }

  Future<CetusCycle> fetchCetusCycle() async {
    final res = await http.get(Uri.https(this.url, platform + "/cetusCycle"));

    print(res.body);

    if (res.statusCode == 200) {
      return CetusCycle.fromJson(jsonDecode(res.body));
    } else {
      print("sumthing wong");
    }
  }
}
