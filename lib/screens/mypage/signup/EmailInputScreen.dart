import 'package:blueberry_flutter_template/widgets/signup/EmailDuplicateWidget.dart';
import 'package:flutter/material.dart';

class EmailInputScreen extends StatelessWidget {
  final VoidCallback onNext;
  const EmailInputScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return EmailDuplicateWidget(onNext: onNext);
  }
}
