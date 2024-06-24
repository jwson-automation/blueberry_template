import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'SignUpPage.dart';

class EmailInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  EmailInputPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => email.state = value,
            decoration: InputDecoration(labelText: '이메일 입력'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: Text('인증번호 전송'),
          ),
        ],
      ),
    );
  }
}
