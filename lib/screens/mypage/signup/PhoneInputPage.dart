
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../../../utils/AppStrings.dart';

import '../../../providers/signup/PhoneVerificationProvider.dart';

// A 스크린 ( 휴대폰 입력 )
class PhoneInputPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const PhoneInputPage({super.key, required this.onNext});

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
    final phoneNumber = ref.watch(phoneNumberProvider.notifier);
    final phoneVerification = ref.watch(phoneVerificationProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: '휴대폰 번호',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            maxLength: 11,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                null,
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
              if (phoneNumber.state.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(AppStrings.errorMessage_emptyPhoneNumber),
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

              final result =
                  await phoneVerification.sendPhoneNumber(phoneNumber.state);

              //전화번호 입력 성공/실패 처리
              if (result) {
                widget.onNext();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(AppStrings.errorMessage_invalidPhoneNumber),
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

  const PhoneVerificationNumberInputPage({super.key, required this.onNext});

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
    final verificationCode = ref.watch(verificationCodeProvider.notifier);
    final phoneVerification = ref.watch(phoneVerificationProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
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
              if (verificationCode.state.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(AppStrings.errorMessage_emptyVerificationCode),
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

              final result =
                  await phoneVerification.verifyCode(verificationCode.state);

              //인증 성공/실패 처리
              if (result) {
                widget.onNext();
              } else {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(AppStrings.errorMessage_invalidVerificationCode),
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

  const PhoneVerificationDonePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('휴대폰 인증 완료'),
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
