import 'package:blueberry_flutter_template/widgets/mbti/MBTIAnswerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/mbti/MBTIQuestionWidget.dart';

class MBTIMainScreen extends StatelessWidget {
  const MBTIMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MBTI")),
      body: Center(
        child: Column(
          children: [
            Expanded(child: MBTIQuestionWidget()),
            Expanded(child: MBTIAnswerWidget()),
          ],
        ),
      )
    );
  }
}
