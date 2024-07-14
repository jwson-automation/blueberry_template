import 'package:blueberry_flutter_template/lesson/LessonListView.dart';
import 'package:blueberry_flutter_template/modules/core/utils/AppStrings.dart';
import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.lessonScreenListDescription)),
      body: Center(child: LessonListView()),
    );
  }
}
