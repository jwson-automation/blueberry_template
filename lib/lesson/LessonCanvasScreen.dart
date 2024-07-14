import 'package:flutter/material.dart';

import 'FirebaseService.dart';
import 'LessonCanvasWidget.dart';

class LessonCanvasScreen extends StatelessWidget {
  LessonCanvasScreen({super.key});

  final firebaseservice = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LessonCanvasWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            firebaseservice.clearPoints();
          },
          child: const Icon(Icons.add),
        ));
  }
}
