import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../SignUpScreen.dart';

class PasswordInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  const PasswordInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => password.state = value,
            decoration: const InputDecoration(labelText: '비밀번호 입력'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class PasswordConfirmPage extends ConsumerWidget {
  final VoidCallback onNext;

  const PasswordConfirmPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordProvider.notifier);
    final passwordConfirm = ref.watch(passwordConfirmProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => passwordConfirm.state = value,
            decoration: const InputDecoration(labelText: '비밀번호 확인'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
