import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../SignUpScreen.dart';

//전화번호인증 provider
final phoneVerificationProvider =
    NotifierProvider<PhoneVerificationNotifier, String>(() {
  return PhoneVerificationNotifier();
});

//전화번호인증 notifier
class PhoneVerificationNotifier extends Notifier<String> {
  @override
  String build() => '';

  Future<bool> sendPhoneNumber(String phoneNumber) async {
    return await sendPhoneNumberForVerification(
        phoneNumber.replaceAll('-', ''));
  }

  Future<bool> sendVerificationNumber(String code) async {
    return await sendCodeForVerification(code.replaceAll('-', ''));
  }
}

//전화번호인증 - 1. 전화번호 입력
class PhoneInputPage extends ConsumerWidget {
  final VoidCallback onNext;

  const PhoneInputPage({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            inputFormatters: [
              CustomPhoneNumberFormatter(),
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumber.state = value,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              final currentPhoneNumber = ref.watch(phoneNumberProvider);

              if (currentPhoneNumber.isEmpty) {
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
                  .sendPhoneNumber(ref.watch(phoneNumberProvider));

              if (result) {
                onNext();
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

//전화번호인증 - 2. 인증번호 입력
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
  Widget build(BuildContext context) {
    final verificationNumber = ref.read(verificationNumberProvider.notifier);
    final phoneVerification = ref.read(phoneVerificationProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            focusNode: _focusNode,
            autofocus: true,
            length: 6,
            onChanged: (value) =>
            verificationNumber.state = value,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await phoneVerification.sendVerificationNumber(verificationNumber.state);
              if (result) {
                widget.onNext();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('인증 코드가 잘못되었습니다.'),
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
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

//전화번호인증 - 3. 전화번호 인증 완료
class PhoneVerificationDonePage extends ConsumerWidget {
  
  final VoidCallback onNext;

  const PhoneVerificationDonePage({required this.onNext});

  @override
  Widget build(BuildContext , WidgetRef ref) {
    // final phoneNumber = ref.read(phoneNumberProvider);
    // final verificationNumber = ref.read(verificationNumberProvider);
    
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('전화전호: $phoneNumber'),
          // Text('인증번호: $verificationNumber'),
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

class CustomPhoneNumberFormatter extends TextInputFormatter {
  final int maxLength;

  CustomPhoneNumberFormatter({this.maxLength = 11});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final truncated = digitsOnly.length <= maxLength
        ? digitsOnly
        : digitsOnly.substring(0, maxLength);

    var formattedText = '';

    for (int i = 0; i < truncated.length; i++) {
      if (i == 3 || i == 7) {
        formattedText += '-';
      }
      formattedText += truncated[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

Future<bool> sendPhoneNumberForVerification(String phoneNumber) async {
  await Future.delayed(Duration(seconds: 1));

  if (phoneNumber.length == 11) {
    return true;
  }

  return false;
}

Future<bool> sendCodeForVerification(String code) async {
  await Future.delayed(Duration(seconds: 1));

  if (code == "123456") {
    return true;
  }

  return false;
}
