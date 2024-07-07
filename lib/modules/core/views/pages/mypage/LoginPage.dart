import 'dart:io';

import 'package:blueberry_flutter_template/modules/core/views/signUp/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/firebase/FirebaseAuthServiceProvider.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';
import '../../../providers/item/square_title.dart';
import '../../../providers/page/page_provider.dart';
import '../../../providers/user/UserInfoProvider.dart';
import '../../../services/SocialAuthService.dart';
import '../../../utils/AppStrings.dart';
import 'MyPage.dart';
import 'ProfileCameraPage.dart';
import 'ProfileGalleryPage.dart';

/// DeleteMyPage.dart
///
/// My Page
/// - 사용자 정보를 보여주는 화면
/// - 사용자 정보 수정 및 로그아웃 기능을 제공
///
/// @jwson-automation

final wantEditAgeProvider = StateProvider<bool>((ref) => false);
final wantEditNameProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 페이지 정보를 가져오는 상태 관리 객체
    final pageState = ref.watch(pageProvider);
    // 로그인 상태를 가져오는 상태 관리 객체
    final loginState = ref.watch(loginStateProvider);

    return Scaffold(
      body: loginState.maybeWhen(
        data: (user) => user != null
            ? PageView(
                controller: pageState.pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                    MyPage(),
                    ProfileCameraPage(),
                    ProfileGalleryPage(),
                  ])
            : _buildLogin(context, ref),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget _buildLogin(BuildContext context, WidgetRef ref) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: AppStrings.emailInputLabel,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.errorMessage_emptyEmail;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return AppStrings.errorMessage_invalidEmail;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: AppStrings.passwordInputLabel,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.errorMessage_emptyPassword;
              }
              if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                  .hasMatch(value)) {
                return AppStrings.errorMessage_invalidPassword;
              }
              return null;
            },
          ),

          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.passwordForgot,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),

          //로그인 버튼 & 회원가입 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    try {
                      await ref
                          .read(firebaseAuthServiceProvider)
                          .signInWithEmailPassword(email, password);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(AppStrings.errorTitle),
                            content: Text('에러: $e'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(AppStrings.okButtonText),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text(AppStrings.loginButtonText),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ),
                child: Text(
                  AppStrings.signUpButtonText,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Google button
              SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                  imagePath: 'assets/login_page_images/google.png'),
              const SizedBox(
                width: 10,
              ),
              //Apple button
              SquareTile(
                  onTap: () => AuthService().signInWithApple(),
                  imagePath: 'assets/login_page_images/apple.png'),
              const SizedBox(
                width: 10,
              ),
              //github button
              SquareTile(
                  onTap: () => AuthService().signInWithGithub(),
                  imagePath: 'assets/login_page_images/github.png'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _uploadProfileImageButtons(FirestoreService firestoreService,
    FirebaseStorageService firebaseStorageService, BuildContext context) {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return IconButton(
    icon: const Icon(Icons.upload_file),
    onPressed: () async {
      try {
        // 이미지 피커를 통해 이미지를 선택
        var imageUrl = '';

        if (kIsWeb) {
          final ImagePicker picker = ImagePicker();
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);

          image?.readAsBytes().then((value) async {
            imageUrl = await firebaseStorageService.uploadImageFromWeb(
                value, ImageType.profileimage,
                fixedFileName: userId);

            firestoreService.createProfileIamge(userId, imageUrl);
          });
        }
        if (!kIsWeb) {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            // 선택된 이미지를 Firebase Storage에 업로드
            imageUrl = await firebaseStorageService.uploadImageFromApp(
                File(pickedFile.path), ImageType.profileimage,
                fixedFileName: userId);

            firestoreService.createProfileIamge(userId, imageUrl);
          }
        }
        if (imageUrl != '') {
          print('Banner created successfully');
        } else {
          throw Exception('Cancel to upload image');
        }
      } catch (e) {
        print('Failed to create banner: $e');
      }
    },
  );
}
