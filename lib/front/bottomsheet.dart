//import 'package:coderatorfoss/back/perms.dart';

import 'package:coderatorfoss/front/dev/devoptions.dart';
import 'package:coderatorfoss/front/logo.dart';
import 'package:coderatorfoss/service/service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class BottomSheetCoderatorMobil extends StatelessWidget {
  const BottomSheetCoderatorMobil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.near_me_rounded),
              title: const Text("Coderator Telegram"),
              onTap: () {
                ul.launch("https://t.me/coderator");
              },
            ),
            ListTile(
              leading: const Icon(Icons.near_me_rounded),
              title: const Text("Coderator Topluluk"),
              onTap: () {
                ul.launch("https://t.me/coderatorchat");
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser),
              title: const Text("Coderator Web"),
              onTap: () {
                ul.launch("https://coderator.net");
              },
            ),
            ListTile(
              leading: const Icon(Icons.source),
              title: const Text("Kaynak kodları"),
              onTap: () {
                ul.launch("https://github.com/codeksion/CoderatorMobil");
              },
            ),
            //GridTile(child: child),
            ListTile(
              leading: const Icon(Icons.developer_mode),
              title: const Text("Geliştirici Seçenekleri"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Scaffold(
                          appBar: AppBar(),
                          body: const DevOptions(),
                        ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("Proje sayfası"),
              onTap: () {
                ul.launch("https://codeksion.net/portfolio/coderatormobil/");
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("Codeksion"),
              onTap: () {
                ul.launch("https://codeksion.net");
              },
            ),
            const Text(
                "Coderator Mobil FOSS kullanıyorsunuz. Yaşasın özgürlük!"),
            GestureDetector(
              child: CodeksionLogo(
                  addpaddingintoiconandchild: false,
                  logo: Text("Coderator Mobil v$version",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 15)),
                  child: const Text("raifpy tarafından, sevgi ile")),
            ),
          ],
        ),
      ),
    );
  }
}
