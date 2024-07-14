import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../SignUpScreen.dart';

// 이메일 인증 로직을 담당하는 Provider
final emailVerificationProvider =
    StateNotifierProvider<EmailVerificationNotifier, EmailVerificationState>(
        (ref) {
  return EmailVerificationNotifier();
});

class EmailVerificationNotifier extends StateNotifier<EmailVerificationState> {
  EmailVerificationNotifier() : super(EmailVerificationInitial());

  Future<void> sendVerificationCode(String email) async {
    try {
      // 이메일 인증 코드 발송 API 호출
      await sendEmailVerificationCode(email);
      state = EmailVerificationCodeSent();
    } catch (e) {
      state = EmailVerificationError(e.toString());
    }
  }

  Future<void> verifyCode(String email, String code) async {
    try {
      // 이메일 인증 코드 검증 API 호출
      await verifyEmailCode(email, code);
      state = EmailVerificationSuccess();
    } catch (e) {
      state = EmailVerificationError(e.toString());
    }
  }
}

// 이메일 인증 상태를 관리하는 클래스들
abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationCodeSent extends EmailVerificationState {}

class EmailVerificationSuccess extends EmailVerificationState {}

class EmailVerificationError extends EmailVerificationState {
  final String message;

  EmailVerificationError(this.message);
}

class EmailInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  EmailInputPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider.notifier);
    final emailVerification = ref.read(emailVerificationProvider.notifier);

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
            onPressed: () async {
              await emailVerification.sendVerificationCode(email.state);
              onNext();
            },
            child: Text('인증번호 전송'),
          ),
        ],
      ),
    );
  }
}

class EmailVerificationPage extends ConsumerWidget {
  final VoidCallback onNext;

  EmailVerificationPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider.notifier);
    final emailVerification = ref.read(emailVerificationProvider.notifier);
    final verificationCode = ref.watch(emailVerificationCodeProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => verificationCode.state = value,
            decoration: InputDecoration(labelText: '이메일 코드 입력'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              try {
                verifyEmailCode(email.state, verificationCode.state);
                onNext();
              } catch (e) {
                print(e);
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

// 예시로 API 호출 메서드를 더미로 구현
Future<void> sendEmailVerificationCode(String email) async {
  await Future.delayed(Duration(seconds: 2));
  // 실제 API 호출 로직이 필요함
}

Future<void> verifyEmailCode(String email, String code) async {
  await Future.delayed(Duration(seconds: 2));
  print("code: $code");
  // 실제 API 호출 로직이 필요함
  if (code != "123456") throw Exception("Invalid code");
}
