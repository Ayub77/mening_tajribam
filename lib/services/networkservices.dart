import 'package:http/http.dart';

class Network {
  static String Base = "192.168.13.36:8000";
  static Map<String, String> headers = {
    'Coutent-Type': 'application/json; charset=UTF-8'
  };

//http api

  static String api_get = "/api/branch/get/search";
  static String api_post = "/api/branch/create";
  static String api_put = "/api/branch/update/";
  static String api_aktive = "/api/branch/setActive/";
  static String api_delete = "/api/branch/delete/";


  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(Base, api);
    var respons = await post(uri, headers: headers, body: params);

    if (respons.statusCode == 200) {
      return respons.body;
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  static Future POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(Base, api);
    var respons = await post(uri, headers: headers, body: params);

    if (respons.statusCode == 200) {
      return respons.body;
    }
    return null;
  }



  static Future PUT(String api,String id, Map<String, dynamic> params) async {
    var uri = Uri.http(Base, api+id);
    var respons = await put(uri, headers: headers, body: params);

    if (respons.statusCode == 200) {
      return respons.body;
    }
    return null;
  }

   static Future DELETE(String api,String id, Map<String, dynamic> params) async {
    var uri = Uri.http(Base, api+id,params);
    var respons = await delete(uri, headers: headers,);

    if (respons.statusCode <= 299) {
      return respons.body;
    }
    return null;
  }
  static Future SETAKTIVE(String api,String id, Map<String, dynamic> params) async {
    var uri = Uri.http(Base, api+id);
    var respons = await put(uri, headers: headers,body: params);

    if (respons.statusCode <= 299) {
      return respons.body;
    }
    return null;
  }

  static Map<String, String> emptyparams() {
    Map<String, String> params = new Map();
    params.addAll({'search': ""});
    return params;
  }

  static Map<String, dynamic> createparams(String title, String id) {
    Map<String, dynamic> params = new Map();
    params.addAll({'title': title, 'parent_id': id});
    return params;
  }
}
