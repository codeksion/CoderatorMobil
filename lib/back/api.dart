import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:coderatorfoss/back/template.dart';

String apiURL = "https://depo.coderator.net";

class ApiRequest {
  String path;

  ApiRequest({this.path = ""});

  Future<http.Response> call() =>
      http.get(Uri.parse(apiURL + path), headers: {"Referer": apiURL});
}

class CourseRequest {
  static String fileid2021 = "MW5FcnhEWGxuSVRTOUkzVkIwWm9JQ3FJMC1CdjVaVGI3";
  static String fileid2020 = "MWE5NWxLdTBsMDZUWnU0V0lnSzF4dl82VUpkdG9Fdjhf";
  static Future<Course> request({required String fileid}) async {
    var res = await http.get(Uri.parse("$apiURL/System/List?id=$fileid"),
        headers: {"Referer": apiURL});
    var b = res.body;
    if (res.statusCode != 200) throw Exception(b);
    return Course.fromJson(jsonDecode(b));
  }
}

class DownloadRequest extends ApiRequest {
  DownloadRequest(String id) : super(path: "/System/CreateToken?id=" + id);

  Future<String> getUrl() async {
    var res = await super.call();
    var b = res.body;
    if (b == "Request Denied.") {
      throw Exception("Request Denied.");
    }

    return apiURL + "/System/Download?token=" + b;
  }

  Future<http.Response> getBody() async {
    return http.get(Uri.parse(await getUrl()), headers: {"Referer": apiURL});
  }
}

//??? Henüz tamamlanmadı.
class DetailSearchRequest extends ApiRequest {
  DetailSearchRequest({required String keyword, required String id})
      : super(path: Uri.encodeFull("/List?id=$id&q=$keyword"));

  Future<Course> course() async {
    var res = await call();
    var body = res.body;
    if (res.statusCode != 200 || res.body == "Request Denied.") {
      throw Exception(body);
    }
    return Course.fromJson(jsonDecode(body));
  }
}
