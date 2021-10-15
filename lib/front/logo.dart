import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CoderatorMobilLogo extends StatelessWidget {
  const CoderatorMobilLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Coderator ",
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 40),
              children: const [
                TextSpan(text: "Mobil ", style: TextStyle()),
                TextSpan(text: "FOSS", style: TextStyle(fontFamily: "origin")),
              ])),
    );
  }
}

class CoderatorMobilPaint extends CustomPainter {
  double screenx, screeny;
  int frequency;
  CoderatorMobilPaint(
      {required this.frequency, this.screenx = 0, this.screeny = 0});
  static CoderatorMobilPaint fromContext(BuildContext context, int frequency) {
    final q = MediaQuery.of(context).size;
    return CoderatorMobilPaint(
        screenx: q.width, screeny: q.height, frequency: frequency);
  }

  @override
  bool shouldRepaint(CustomPainter _) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final points = List<Offset>.generate(
        random.nextInt(frequency),
        (index) => Offset(random.nextInt(screenx.toInt()).toDouble(),
            random.nextInt(screeny.toInt()).toDouble()));
    canvas.drawPoints(
        ui.PointMode.points,
        points,
        Paint()
          ..color = Colors.white24
          ..style = PaintingStyle.fill
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round);
  }
}

class CodeksionLogo extends StatefulWidget {
  final String? product;
  final Widget? logo;
  final Widget? child;
  final bool backgroundpoints;
  final bool addpaddingintoiconandchild;

  CodeksionLogo(
      {Key? key,
      this.product,
      this.logo,
      this.backgroundpoints = true,
      this.child,
      this.addpaddingintoiconandchild = true})
      : super(key: key) {
    assert(logo != null || product != null);
  }

  @override
  _CodeksionLogoState createState() => _CodeksionLogoState();
}

class _CodeksionLogoState extends State<CodeksionLogo> {
  Widget _widgetwithpoints(Widget child, BuildContext ctx) {
    if (widget.backgroundpoints) {
      return GestureDetector(
        onTap: () => setState(() {}),
        child: CustomPaint(
            foregroundPainter: CoderatorMobilPaint.fromContext(ctx, 200),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: child,
            )),
      );
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: (widget.product != null)
                  ? Text(
                      widget.product!.replaceAll(" ", "\n"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    )
                  : widget.logo!),
          Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: RichText(
                text: TextSpan(
                  text: "from ",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 15),
                  children: [
                    TextSpan(
                        style: const TextStyle(fontFamily: "origin"),
                        children: [
                          const TextSpan(
                            text: "<C",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: "O",
                            style: TextStyle(color: Colors.green[300]),
                          ),
                          TextSpan(
                            text: "D",
                            style: TextStyle(color: Colors.pink[600]),
                          ),
                          TextSpan(
                            text: "E",
                            style: TextStyle(color: Colors.yellow[500]),
                          ),
                          TextSpan(
                            text: "K",
                            style: TextStyle(color: Colors.orange[300]),
                          ),
                          TextSpan(
                            text: "SI",
                            style: TextStyle(color: Colors.purple[700]),
                          ),
                          TextSpan(
                            text: "ON>",
                            style: TextStyle(color: Colors.pink[500]),
                          ),
                        ]),
                  ],
                ),
              )),
          if (widget.child != null)
            Container(
              padding: (widget.addpaddingintoiconandchild)
                  ? EdgeInsets.only(top: 10)
                  : null,
              child: Opacity(
                opacity: 0.2,
                child: widget.child!,
              ),
            ),
        ],
      ),
    );
  }
}
