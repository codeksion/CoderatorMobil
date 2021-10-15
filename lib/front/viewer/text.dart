import 'dart:convert';

import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextViewer extends StatelessWidget {
  final String id;
  final String title;
  final bool dontuseappbar;
  const TextViewer(
      {Key? key,
      required this.id,
      this.title = "Text Viewer",
      this.dontuseappbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (dontuseappbar)
          ? null
          : AppBar(
              title: Text(title),
            ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: DownloadRequest(id).getBody(),
          builder: (context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return ArsivError(
                snapshot.error,
                stackTrace: snapshot.stackTrace,
                ek: "id: " + id,
                showError: false,
                title: "Metin görüntülenemedi!",
              );
            }

            return SingleChildScrollView(
              child: SelectableText(
                const Utf8Decoder()
                    .convert(snapshot.data!.bodyBytes)
                    .trim()
                    .replaceAll("\t", "    ")
                    .replaceAll("\r", ""),
                enableInteractiveSelection: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
