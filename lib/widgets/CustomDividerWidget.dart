import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[100],
    );
  }
}
