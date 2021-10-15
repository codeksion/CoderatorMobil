import 'package:coderatorfoss/front/home.dart';
import 'package:coderatorfoss/front/logo.dart';
import 'package:coderatorfoss/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart' as tema;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    theme: tema.FlexColorScheme.dark().toTheme,
    //darkTheme: tema.FlexColorScheme.dark().toTheme,
    home: const _home(
      Home(),
    ),
  ));
}

class _home extends StatelessWidget {
  final Widget child;
  const _home(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CodeksionLogo(
            // from Codeksion
            logo: const CoderatorMobilLogo(), // Coderator Mobil FOSS
            child: StreamBuilder(
              //future: initServiceBools(),
              stream: initCoderatorMobil(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "${snapshot.error.toString().replaceAll("Exception: ", "")}\nLütfen internet bağlantını kontrol et.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  return Text(snapshot.data!);
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  () async {
                    await Future.delayed(const Duration(seconds: 2));

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  }();

                  return const Icon(Icons.done);
                }

                return const CircularProgressIndicator();
              },
            )),
      );
}
