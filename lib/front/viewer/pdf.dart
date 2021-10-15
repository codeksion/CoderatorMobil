import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatelessWidget {
  final String id;
  final String title;
  const PdfViewer({Key? key, required this.id, this.title = "Pdf Viewer"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DownloadRequest(id).getUrl(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
            ),
          );
        }

        if (snapshot.hasError) {
          return ArsivError(
            snapshot.error,
            stackTrace: snapshot.stackTrace,
            ek: "pdf id: " + id,
            showError: false,
          );
        }

        return FutureBuilder(
          future: PDFDocument.fromURL(snapshot.data!,
              headers: {"Referer": snapshot.data!}),
          builder: (context, AsyncSnapshot<PDFDocument> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }

            if (snapshot.hasError) {
              return ArsivError(
                snapshot.error,
                stackTrace: snapshot.stackTrace,
                ek: "pdf id: " + id,
                showError: true,
              );
            }
            return Scaffold(
              body: PDFViewer(
                document: snapshot.data!,
                enableSwipeNavigation: true,
                lazyLoad: false,
                showNavigation: true,
                showPicker: true,
              ),
              appBar: AppBar(title: Text(title)),
            );
          },
        );
      },
    );
  }
}
