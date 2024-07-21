import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/widgets/mbti/MBTIHomeWidget.dart';
import 'package:flutter/material.dart';

class MBTIScreen extends StatelessWidget {
  const MBTIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleMBTI)),
      body: const Center(
        child: Column(
          children: [
            Expanded(child: MBTIHomeWidget()),
          ],
        ),
      ),
    );
  }
}
