import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'SignUpPage.dart';

final signUpProvider = FutureProvider((ref) async {
  // Simulate a network request with a 2-second delay
  await Future.delayed(Duration(seconds: 2));

  return true;
});

Future<bool>

class ConfirmationPage extends ConsumerWidget {
  final VoidCallback onNext;

  ConfirmationPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider.notifier);
    final name = ref.read(nameProvider.notifier);
    final nickname = ref.read(nicknameProvider.notifier);
    final password = ref.read(passwordProvider.notifier);
    final isLoading = ref.watch(signUpProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('이메일: ${email.state}'),
          SizedBox(height: 20),
          Text('이름: ${name.state}'),
          SizedBox(height: 20),
          Text('닉네임: ${nickname.state}'),
          SizedBox(height: 20),
          Text('비밀번호: ${password.state}'),
          SizedBox(height: 20),
          isLoading.when(
            data: (value) => ElevatedButton(
              onPressed: onNext,
              child: Text('가입하기'),
            ),
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
