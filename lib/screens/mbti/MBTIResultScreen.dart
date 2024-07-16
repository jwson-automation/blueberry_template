import 'package:flutter/material.dart';

class MBTIResultScreen extends StatelessWidget {
  const MBTIResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("MBTI")),
        body: Center(
          child: Column(
            children: [
              // Expanded(child: MBTIAnswerWidget()),
            ],
          ),
        ));
  }
}
