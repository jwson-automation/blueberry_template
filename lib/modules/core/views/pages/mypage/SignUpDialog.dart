import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dto/UserDto.dart';
import '../../../providers/firebase/FirebaseAuthServiceProvider.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';
import '../../../utils/AppStrings.dart';

/**
 * SignUpDialog.dart
 *
 * 회원가입 다이얼로그
 * - 이메일, 비밀번호를 입력받아 회원가입을 진행합니다.
 *
 * @jwson-automation
 */

class SignUpDialog extends ConsumerWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final fireStoreService = ref.read(fireStorageServiceProvider);

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            AppStrings.signUpPageTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          // 다이얼로그의 contentPadding을 조정하여 여백을 줍니다.
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: AppStrings.emailInputLabel,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.errorMessage_emptyEmail;
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return AppStrings.errorMessage_invalidEmail;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.passwordInputLabel,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.errorMessage_emptyPassword;
                      }
                      if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
                        return AppStrings.errorMessage_invalidPassword;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppStrings.cancelButtonText,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  try {
                    // 사용자 계정 생성
                    var userCredential = await ref
                        .read(firebaseAuthServiceProvider)
                        .signUpWithEmailPassword(email, password);

                    // 새로운 UserDTO 인스턴스 생성
                    UserDTO newUser = UserDTO(
                        userId: userCredential!.uid,
                        email: email,
                        name: '', // 초기 이름 값, 필요에 따라 수정
                        age: 0, // 초기 나이 값, 필요에 따라 수정
                        profileImageUrl: '', // 초기 프로필 사진 URL, 필요에 따라 수정
                        createdAt: DateTime.now() // 계정 생성 날짜
                    );

                    // Firestore에 사용자 정보 저장
                    await ref.read(firebaseStoreServiceProvider).createUser(newUser);

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.signUpSuccessMessage)),
                    );
                  } catch (e) {
                    // 회원가입 실패 시, 에러 메시지 출력
                    print('회원가입 실패: $e');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('회원가입 실패: $e'),
                    ));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                AppStrings.signUpButtonText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
