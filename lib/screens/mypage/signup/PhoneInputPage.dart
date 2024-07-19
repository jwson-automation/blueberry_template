import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

// 휴대폰인증 provider
final phoneNumberProvider = StateProvider<String>((ref) => '');
final verificationCodeProvider = StateProvider<String>((ref) => '');
final phoneVerificationProvider =
    NotifierProvider<PhoneVerificationNotifier, PhoneVerificationState>(() {
  return PhoneVerificationNotifier();
});

class PhoneVerificationNotifier extends Notifier<PhoneVerificationState> {
  @override
  PhoneVerificationState build() {
    return VerificationInitialize();
  }

  Future<bool> requestCode(String phoneNumber) async {
    try {
      await requestPhoneVerificationCode(phoneNumber);
      state = VerificationRequest();
      return true;
    } catch (e) {
      state = VerificationError(e.toString());
      return false;
    }
  }

  Future<bool> verifyCode(String phoneNumber, String code) async {
    try {
      await verifyPhoneVerificationCode(phoneNumber, code);
      state = VerificationSuccess();
      return true;
    } catch (e) {
      state = VerificationError(e.toString());
      return false;
    }
  }
}

// 휴대폰인증 상태관리 클래스
abstract class PhoneVerificationState {}

class VerificationInitialize extends PhoneVerificationState {
  final String phoneNumber;
  final String verificationNumber;

  VerificationInitialize({this.phoneNumber = '', this.verificationNumber = ''});
}

class VerificationRequest extends PhoneVerificationState {}

class VerificationSuccess extends PhoneVerificationState {}

class VerificationError extends PhoneVerificationState {
  final String message;

  VerificationError(this.message);
}

// A 스크린 ( 휴대폰 입력 )
class PhoneInputPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const PhoneInputPage({required this.onNext});

  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends ConsumerState<PhoneInputPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(phoneNumberProvider.notifier).state = '';
      ref.read(verificationCodeProvider.notifier).state = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ref.read(phoneNumberProvider.notifier);
    final phoneVerification = ref.read(phoneVerificationProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: '휴대폰 번호',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumber.state = value,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              //전화번호 미입력
              if (ref.read(phoneNumberProvider).isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('휴대폰 번호를 입력해주세요.'),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              final result = await phoneVerification
                  .requestCode(ref.read(phoneNumberProvider));

              //전화번호 입력 성공/실패 처리
              if (result) {
                widget.onNext();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('휴대폰 번호를 확인해주세요.'),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('다음'),
          ),
        ],
      ),
    );
  }
}

// B 스크린 ( 휴대폰 인증번호 입력 )
class PhoneVerificationNumberInputPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  PhoneVerificationNumberInputPage({required this.onNext});

  @override
  _PhoneVerificationNumberInputPageState createState() =>
      _PhoneVerificationNumberInputPageState();
}

class _PhoneVerificationNumberInputPageState
    extends ConsumerState<PhoneVerificationNumberInputPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ref.read(phoneNumberProvider.notifier);
    final verificationCode = ref.read(verificationCodeProvider.notifier);
    final phoneVerification = ref.read(phoneVerificationProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            focusNode: _focusNode,
            autofocus: true,
            showCursor: true,
            length: 6,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) => verificationCode.state = value,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              // 인증번호 미입력
              if (ref.read(verificationCodeProvider).isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('인증번호를 입력해주세요.'),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              final result = await phoneVerification.verifyCode(
                  phoneNumber.state, verificationCode.state);

              //인증 성공/실패 처리
              if (result) {
                widget.onNext();
              } else {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('인증번호를 확인해주세요.'),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                FocusScope.of(context).requestFocus(_focusNode);
              }
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

// C 스크린 ( 휴대폰  인증 완료 후 보여줄 화면 )
class PhoneVerificationDonePage extends ConsumerWidget {
  final VoidCallback onNext;

  const PhoneVerificationDonePage({required this.onNext});

  @override
  Widget build(BuildContext, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('휴대폰 인증 완료'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => onNext(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

// 휴대폰번호 전송 로직 (구현 필요)
Future<bool> requestPhoneVerificationCode(String phoneNumber) async {
  await Future.delayed(Duration(seconds: 1));

  if (phoneNumber.length == 10 || phoneNumber.length == 11) {
    return true;
  }

  throw Exception("Invalid phone number");
}

// 인증번호 전송 로직 (구현 필요)
Future<bool> verifyPhoneVerificationCode(
    String phoneNumber, String code) async {
  await Future.delayed(Duration(seconds: 1));

  if (code == "123456") {
    return true;
  }

  throw Exception("Invalid verification code");
}
