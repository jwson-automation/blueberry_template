import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../SignUpScreen.dart';

class NameInputScreen extends StatelessWidget {
  final VoidCallback onNext;
  const NameInputScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return NameInputScreen(onNext: onNext);
  }
}


class NameInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  const NameInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider.notifier);
    final nickname = ref.watch(nicknameProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => name.state = value,
            decoration: const InputDecoration(labelText: '이름 입력'),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) => nickname.state = value,
            decoration: const InputDecoration(labelText: '닉네임 입력'),
          ),
          ElevatedButton(
            onPressed: onNext,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
