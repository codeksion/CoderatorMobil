import 'package:coderatorfoss/back/template.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:coderatorfoss/front/viewer/mime.dart';

import 'package:flutter/material.dart';

double getW(BuildContext context) => MediaQuery.of(context).size.width;
double getH(BuildContext context) => MediaQuery.of(context).size.height;

class CourseListView extends StatefulWidget {
  Course? course;
  final bool appbar;
  final String appbarTitle;

  final String id;

  CourseListView(
    this.id, {
    Key? key,
    this.appbar = false,
    this.appbarTitle = "",
  }) : super(key: key);

  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  dynamic error;
  StackTrace? _stackTrace;
  String filter = "";

  bool itemFilter(Items i) {
    if (filter == "") return true;

    return i.name.toLowerCase().contains(filter.toLowerCase());
  }

  Widget withRefresh({required Widget child}) => RefreshIndicator(
      child: child,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        setState(() {
          error = null;
          widget.course = null;
        });
      });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return ArsivError(
        error,
        stackTrace: _stackTrace,
        navigatorPoponClick: false,
        title: "Sunucuya erişilemedi!",
        refreshTitle: "Bir daha istek atayım",
        refresh: () {
          setState(() {
            error = null;
          });
        },
      );
    }

    if (widget.course == null) {
      CourseRequest.request(fileid: widget.id)
          .then((value) => setState(() {
                error = null;
                widget.course = value;
              }))
          .catchError((e, s) {
        setState(() {
          error = e;
          _stackTrace = s;
        });
        //return false;
      });

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: (!widget.appbar)
            ? null
            : AppBar(
                title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      widget.appbarTitle,
                      //overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              )),
        body: withRefresh(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            addSemanticIndexes: true,
            children: <Widget>[
                  courseSearch(),
                ] +
                getCourseList(widget.course!),
          ),
        ));
  }

  List<Widget> getCourseList(Course c) {
    List<Widget> liste = [];

    for (var i in c.items!) {
      if (itemFilter(i)) {
        liste.add(courseOnIzleme(i));
      }
    }

    return liste;
  }

  Widget courseSearch() => Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: TextField(
            decoration: const InputDecoration.collapsed(
              hintText: "Ara",
            ),
            onChanged: (String veri) {
              setState(() {
                filter = veri;
              });
            },
          ),
        ),
      );

  Widget courseOnIzleme(Items i) => InkWell(
        onTap: () => MimeYonlendirici(context, i),
        child: Card(
          child: Container(
              height: 40,
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: [
                        //Flexible(child: )
                        Icon(mimeToIconData(i.mimeType)),

                        Flexible(
                          child: Text(
                            " " + i.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //fit: FlexFit.loose,
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
}

/*
GridView.builder(
              itemCount: widget.course!.items!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ((getW(context) ~/ 200))),
              itemBuilder: (context, index) =>
                  CourseOnIzleme(widget.course!.items![index]))
*/ //Elbet bir gün lazım olur. Kalsın burada :)
bool isDir(String mime) => "application/vnd.google-apps.folder" == mime;

IconData mimeToIconData(String mime) {
  switch (mime) {
    case "application/vnd.google-apps.folder":
      {
        return Icons.folder_open_rounded;
      }
    case "application/pdf":
      {
        return Icons.picture_as_pdf;
      }
    case "text/html":
      {
        return Icons.web_asset;
      }
    case "text/plain":
      {
        return Icons.text_snippet;
      }
  }

  var s = mime.split("/");
  switch (s[0]) {
    case "image":
      {
        return Icons.photo;
      }
    case "video":
      {
        return Icons.play_arrow;
      }
  }

  return Icons.file_present_rounded;
}
