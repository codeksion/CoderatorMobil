import 'package:coderatorfoss/back/template.dart';
import 'package:coderatorfoss/front/course/listview.dart';
import 'package:coderatorfoss/front/viewer/html.dart';
import 'package:coderatorfoss/front/viewer/image.dart';
import 'package:coderatorfoss/front/viewer/pdf.dart';
import 'package:coderatorfoss/front/viewer/text.dart';
import 'package:coderatorfoss/front/viewer/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void MimeYonlendirici(BuildContext context, Items i) {
  Widget? w;

  switch (i.mimeType) {
    case "application/vnd.google-apps.folder":
      w = CourseListView(
        i.id,
        appbar: true,
        appbarTitle: i.name,
      );
      break;
    case "text/html":
      {
        w = HtmlViewer(
          id: i.id,
          title: i.name,
        );
        break;
      }

    case "application/pdf":
      {
        w = PdfViewer(
          id: i.id,
          title: i.name,
        );
      }
  }

  if (w == null) {
    var ms = i.mimeType.split("/");

    switch (ms[0]) {
      case "video":
        w = VideoViewer(
          id: i.id,
          title: i.name,
          //local: local,
        );
        break;
      case "image":
        w = ImageViewer(
          id: i.id,
          title: i.name,
          //local: local,
        );
        break;
      case "text":
        w = TextViewer(
          id: i.id,
          title: i.name,
          //local: local,
        );
    }
  }

  if (w == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${i.mimeType} görüntüleyemiyorum!")));
    return;
  }

  Navigator.push(context, MaterialPageRoute(builder: (context) => w!));
}
