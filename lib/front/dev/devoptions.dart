import 'package:flutter/material.dart';

class DevOptions extends StatelessWidget {
  const DevOptions({Key? key}) : super(key: key);

  Widget nesne(String text, Widget? child) => Card(
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(text)),
              child ?? Container(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            nesne(
                "Google reklamlarını göster",
                Switch(
                  onChanged: (value) {},
                  value: false,
                )),
          ],
        ),
      ),
    );
  }
}
