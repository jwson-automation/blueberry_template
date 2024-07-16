import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/mbti/MBTIQuestionWidget.dart';

class MBTITestScreen extends StatelessWidget {
  const MBTITestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: MBTIQuestionWidget()),
            ],
          ),
        )
    );
  }
}
