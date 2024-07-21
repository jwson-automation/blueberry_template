import 'package:blueberry_flutter_template/providers/user/SignUpEmailDuplicationProvider.dart';
import 'package:blueberry_flutter_template/screens/mypage/SignUpScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/signup/EmailInputPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EmailDuplicateWidget extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const EmailDuplicateWidget({super.key, required this.onNext});

  @override
  _EmailDuplicateWidgetState createState() => _EmailDuplicateWidgetState();
}

class _EmailDuplicateWidgetState extends ConsumerState<EmailDuplicateWidget> {
  final TextEditingController _emailController = TextEditingController();
  bool isEmailAvailable = false;

  @override
  Widget build(BuildContext context) {
    final email = ref.read(emailProvider.notifier);
    final emailVerification = ref.read(emailVerificationProvider.notifier);
    final emailDuplicate = ref.watch(emailDuplicateProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            onChanged: (value) => email.state = value,
            decoration: const InputDecoration(labelText: '이메일 입력'),
          ),
          const SizedBox(height: 20),

              _duplicationBtn(emailDuplicate, context),

          const SizedBox(height: 20),

          _verifyBtn(emailVerification, email),
        ],
      ),
    );
  }

  ElevatedButton _verifyBtn(EmailVerificationNotifier emailVerification, StateController<String> email) {
    return ElevatedButton(
      onPressed: () async {
        await emailVerification.sendVerificationCode(email.state);
        widget.onNext();
      },
      child: const Text('인증번호 전송'),
    );
  }

  ElevatedButton _duplicationBtn(EmailDuplicateNotifier emailDuplicate, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String email = _emailController.text;
        bool isDuplicate = await emailDuplicate.isDuplication(email);
        if (isDuplicate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('중복된 이메일입니다.')),
          );
          setState(() {
            isEmailAvailable = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사용 가능한 이메일입니다.')),
          );
          setState(() {
            isEmailAvailable = true;
          });
        }
      },
      child: const Text('중복 확인'),
    );
  }
}

