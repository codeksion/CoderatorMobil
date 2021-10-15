import 'dart:convert';

import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:coderatorfoss/front/viewer/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HtmlViewer extends StatelessWidget {
  final String id;
  final String? title;

  const HtmlViewer({Key? key, required this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DownloadRequest(id).getBody(),
      builder: (context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

        if (snapshot.hasError) {
          return ArsivError(
            snapshot.error,
            stackTrace: snapshot.stackTrace,
          );
        }
        //var databytes = snapshot.data!.body;

        return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(title: Text(title ?? "Html Viewer")),
              bottomNavigationBar: const TabBar(
                tabs: [
                  Tab(
                    text: "HTML",
                  ),
                  Tab(
                    text: "SRC",
                  ),
                ],
              ),
              body: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Html(
                          data:
                              const Utf8Decoder() //!!! Yakalanmayan hataya sebep olabilir.
                                  .convert(snapshot.data!.bodyBytes),
                          onLinkTap: (url, rcontext, attributes, element) {
                            if (url == null) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                action: SnackBarAction(
                                    label: "Neden olmasın?",
                                    onPressed: () => launch(url)),
                                content: Tooltip(
                                  message: url,
                                  child: const Text(
                                    "Gerçekten bu bağlantıyı açmak istiyor musun?",
                                  ),
                                )));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextViewer(
                  //??? Sunucuya tekrar istek atmasına sebep olacak.
                  id: id,
                  dontuseappbar: true,
                ),
              ]),
            ));
      },
    );
  }

  void onError(BuildContext context, dynamic error) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
}
