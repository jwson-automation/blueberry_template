import 'dart:ui';

import 'package:blueberry_flutter_template/lesson/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LessonCanvasProvider.dart'; // lessonCanvasProvider

class LessonCanvasWidget extends StatelessWidget {
  final firebaseservice = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        firebaseservice.addPoint(localPosition);
      },
      child: Consumer(
        builder: (context, ref, _) {
          final _points = ref.watch(lessonCanvasProvider);
          return _points.when(
            data: (points) => _buildCanvas(points),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  Widget _buildCanvas(List<Offset> points) {
    return CustomPaint(
      painter: DrawingPainter(points),
      child: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (i > 0) {
        // 현재 점과 이전 점을 연결하여 선을 그리는 것이 아니라,
        // 각 점을 개별적으로 그립니다.
        canvas.drawPoints(PointMode.points, [points[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
