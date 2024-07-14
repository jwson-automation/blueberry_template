import 'package:blueberry_flutter_template/lesson/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LessonCanvasProvider.dart'; // lessonCanvasProvider

class LessonCanvasWidget extends StatelessWidget {
  final firebaseservice = FirebaseService();
  Offset? _startPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        _startPosition = renderBox.globalToLocal(details.globalPosition);
      },
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset endPosition = renderBox.globalToLocal(details.globalPosition);

        if (_startPosition != null) {
          firebaseservice.addLine(_startPosition!, endPosition);
          _startPosition = endPosition; // Update start position
        }
      },
      onPanEnd: (details) {
        _startPosition = null;
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

  Widget _buildCanvas(List<Map<String, Offset>> points) {
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
  final List<Map<String, Offset>> lines;

  DrawingPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var line in lines) {
      Offset start = line['start'] ?? Offset.zero;
      Offset end = line['end'] ?? Offset.zero;
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
