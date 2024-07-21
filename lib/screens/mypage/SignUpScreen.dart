import 'package:blueberry_flutter_template/screens/mypage/signup/EmailInputScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/signup/PasswordInputPage.dart';
import 'package:blueberry_flutter_template/screens/mypage/signup/TermsOfServicePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'signup/ConfirmationPage.dart';
import 'signup/EmailInputPage.dart';
import 'signup/NameInputPage.dart';
import 'signup/PrivacyPolicyPage.dart';

final PageController _pageController = PageController();

// 이메일 인증 ( 아이디 )
final emailProvider = StateProvider<String>((ref) => '');
final emailVerificationCodeProvider = StateProvider<String>((ref) => '');

// 이름, 닉네임 생성
final nameProvider = StateProvider<String>((ref) => '');
final nicknameProvider = StateProvider<String>((ref) => '');

// 비밀번호 생성
final passwordProvider = StateProvider<String>((ref) => '');
final passwordConfirmProvider = StateProvider<String>((ref) => '');

// 휴대폰 번호 인증 ( 구매할 때 휴대폰 인증 ) ( 따로 만들기 )
final residentRegistrationNumberProvider = StateProvider<String>((ref) => '');
final phoneNumberProvider = StateProvider<String>((ref) => '');
final verificationNumberProvider = StateProvider<String>((ref) => '');

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EmailInputScreen(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          EmailVerificationPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          NameInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PasswordInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PasswordConfirmPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          TermsOfServicePage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PrivacyPolicyPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          ConfirmationPage(
            onNext: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
