import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/bottomsheet.dart';

import 'package:coderatorfoss/front/course/listview.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(children: [
          CourseListView(
            CourseRequest.fileid2020,
            appbarTitle: "coderatorfoss20",
          ),
          CourseListView(
            CourseRequest.fileid2021,
            appbarTitle: "coderatorfoss21",
          ),
        ]),
        bottomNavigationBar: Row(
          children: [
            //PopupMenuButton(itemBuilder: []),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => const BottomSheetCoderatorMobil());
                },
                icon: const Icon(Icons.info)),
            const Flexible(
                child: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.category_sharp),
              ),
              Tab(
                icon: Icon(Icons.format_list_bulleted_outlined),
              ),
            ])),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () => launch("https://t.me/coderatorchat"),
            ),
          ],
        ),
      ),
    );
  }
}
