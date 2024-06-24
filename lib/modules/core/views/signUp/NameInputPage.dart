import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'SignUpPage.dart';

class NameInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  NameInputPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationCode = ref.watch(nameProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => verificationCode.state = value,
            decoration: InputDecoration(labelText: '이름 입력'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
