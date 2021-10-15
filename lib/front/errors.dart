import 'package:flutter/material.dart';

class FatalError extends StatelessWidget {
  final dynamic error;

  const FatalError(this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Beklenmeyen bir hata ile karşılaşıldı.",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text("Hata: ${error.toString()}"),
            const Text("Lütfen bunu bildir!"),
          ],
        ),
      ));
}

class ArsivError extends StatelessWidget {
  final dynamic error;
  final StackTrace? stackTrace;
  final String title;
  final Function? refresh;
  final String refreshTitle;
  final bool navigatorPoponClick;
  final dynamic ek;

  final bool showError;

  //late TextStyle textstyle;

  const ArsivError(
    this.error, {
    Key? key,
    this.stackTrace,
    this.showError = true,
    this.refresh,
    this.refreshTitle = "Yenile",
    this.navigatorPoponClick = true,
    this.ek,
    this.title = "Bir hata ile karşılaşıldı",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () {
            if (navigatorPoponClick) Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SelectableText(
                      error.toString(),
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    const Text("Foss sürümleri hata rapor edemiyor :)"),
                  ],
                ),
                if (refresh != null)
                  Positioned(
                    bottom: 10,
                    child: TextButton(
                        onPressed: () {
                          refresh!();
                        },
                        child: Text(refreshTitle)),
                  ),
              ],
            ),
          ),
        ),
      );
}
