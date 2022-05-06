import 'package:demopatient/utilities/color.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = appBarColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * .04, size.height * .7, size.width * .2, size.height * .7);
    path.lineTo(size.width * .8, size.height * .7);
    path.quadraticBezierTo(
        size.width, size.height * .7, size.width, size.height * .5);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
