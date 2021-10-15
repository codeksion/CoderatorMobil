import 'dart:io';
import 'package:coderatorfoss/back/api.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

//bool firstopen = false;
const version = 0.9;

late Directory approotpath;
Directory downloadspath = Directory("/storage/emulated/0/Download/");

File addapprootpath(String path) => File(approotpath.path + "/" + path);
//bool parseHTML = true;

Stream<String> initCoderatorMobil() async* {
  approotpath = await getApplicationSupportDirectory();

  if (Platform.isLinux) {
    downloadspath = (await getDownloadsDirectory())!;
  }
  WidgetsFlutterBinding.ensureInitialized();

  yield "sunucuya istek atılıyor";
  try {
    var response = await http.get(Uri.parse(apiURL));
    if (response.statusCode != 200) {
      throw Exception("Beklenmeyen yanıt kodu: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Sunucuya erişilemedi :/\n$e");
  }
}
