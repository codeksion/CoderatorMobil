import 'dart:typed_data';

import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String id;
  final String title;
  const ImageViewer({Key? key, required this.id, this.title = "Image Viewer"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DownloadRequest(id).getUrl(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            ArsivError(
              snapshot.error,
              stackTrace: snapshot.stackTrace,
              showError: true,
              ek: "image-view-id: " + id,
              navigatorPoponClick: true,
              title: "Resim görüntülenemedi",
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
                child: Ink.image(
                    onImageError: (exception, stackTrace) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArsivError(
                              exception,
                              stackTrace: stackTrace,
                              title: "Resim görüntülenemedi!",
                            ),
                          ));
                    },
                    image: NetworkImage(snapshot.data!,
                        headers: {"Referer": snapshot.data!}))),
          );
        });
  }
}
