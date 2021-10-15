import 'dart:convert';
import 'dart:io';
import 'package:coderatorfoss/back/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class Course {
  List<Items>? items;

  Course({this.items});

  Course.fromJson(Map<String, dynamic> json) {
    if (json['Items'] != null) {
      items = <Items>[];
      json['Items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  static Course fromDirectory(Directory dir) {
    List<Items> items = [];
    for (var i in dir.listSync()) {
      var stat = i.statSync();
      var iii = Items(
        name: basename(i.path),
        id: "",
        size: "${stat.size / 1024 / 1024}MB",
        modTime: "",
        mimeType: "",
      )
        ..islocal = true
        ..localpath = i.path;

      if (stat.type == FileSystemEntityType.directory) {
        iii.mimeType = "application/vnd.google-apps.folder";
      } else {
        iii.mimeType = lookupMimeType(iii.name) ?? "unknown";
      }

      items.add(iii);
    }

    return Course()..items = items;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (items != null) {
      data['Items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  late String name;
  late String id;
  late String size;
  late String modTime;
  late String mimeType;
  bool? islocal;
  String? localpath;

  Items(
      {required this.name,
      required this.id,
      required this.size,
      required this.modTime,
      required this.mimeType});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['Name'] ?? "";
    id = json['Id'] ?? "";
    size = json['Size'] ?? "";
    modTime = json['ModTime'] ?? "";
    mimeType = json['MimeType'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Name'] = name;
    data['Id'] = id;
    data['Size'] = size;
    data['ModTime'] = modTime;
    data['MimeType'] = mimeType;
    return data;
  }
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
