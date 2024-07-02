import 'package:flutter/material.dart';


class DarkenOutsideCirclePainter extends CustomPainter {
  final double radius;

  DarkenOutsideCirclePainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius))
      ..addRect(rect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}