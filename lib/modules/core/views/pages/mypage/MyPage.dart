import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';
import '../../../providers/item/square_title.dart';
import '../../../providers/user/ProfileImageProvider.dart';
import '../../../providers/user/UserInfoProvider.dart';
import '../../../providers/firebase/FirebaseAuthServiceProvider.dart';
import '../../../services/SocialAuthService.dart';
import '../../../utils/AppStrings.dart';
import 'SignUpDialog.dart';

/// MyPage.dart
///
/// My Page
/// - 사용자 정보를 보여주는 화면
/// - 사용자 정보 수정 및 로그아웃 기능을 제공
///
/// @jwson-automation

final wantEditAgeProvider = StateProvider<bool>((ref) => false);
final wantEditNameProvider = StateProvider<bool>((ref) => false);

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 유저 정보를 가져오는 상태 관리 객체
    final loginState = ref.watch(loginStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myPageTitle),
      ),
      body: loginState.maybeWhen(
        data: (user) => user != null
            ? _buildUserDetails(context, ref)
            : _buildLogin(context, ref),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget _buildUserDetails(BuildContext context, WidgetRef ref) {
  final user = ref.watch(userInfoNotifierProvider);
  final profileImage = ref.watch(profileImageStreamProvider);

  final wantEditName = ref.watch(wantEditNameProvider);
  final wantEditAge = ref.watch(wantEditAgeProvider);

  TextEditingController nameController = TextEditingController(text: user.name);
  TextEditingController ageController =
      TextEditingController(text: user.age.toString());

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            profileImage.when(
                data: (imageUrl) => CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                loading: () => const CircularProgressIndicator(),
                error: (e, s) => CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                    )),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // 아이콘 배경색으로 흰색을 사용합니다.
                  shape: BoxShape.circle, // 원형으로 배경을 설정합니다.
                  border: Border.all(
                    color: Colors.grey.shade300, // 테두리 색상 설정
                    width: 2, // 테두리 두께 설정
                  ),
                ),
                child: _uploadProfileImageButtons(
                    ref.read(firebaseStoreServiceProvider),
                    ref.read(fireStorageServiceProvider),
                    context),
              ),
            ),
          ],
        ),
        Text(user.email, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  wantEditName
                      ? Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (nameController) {
                              ref
                                  .read(userInfoNotifierProvider.notifier)
                                  .updateUser(name: nameController);
                              ref.read(wantEditNameProvider.notifier).state =
                                  false;
                            },
                          ),
                        )
                      : Text('Name: ${user.name}',
                          style: const TextStyle(fontSize: 20)),
                  wantEditName
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(userInfoNotifierProvider.notifier)
                                .updateUser(name: nameController.text);
                            ref.read(wantEditNameProvider.notifier).state =
                                !wantEditName;
                          },
                          icon: const Icon(Icons.save))
                      : IconButton(
                          onPressed: () {
                            ref.read(wantEditNameProvider.notifier).state =
                                !wantEditName;
                          },
                          icon: const Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  wantEditAge
                      ? Expanded(
                          child: TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      : Text('Age: ${user.age}',
                          style: const TextStyle(fontSize: 16)),
                  wantEditAge
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(userInfoNotifierProvider.notifier)
                                .updateUser(age: int.parse(ageController.text));
                            ref.read(wantEditAgeProvider.notifier).state =
                                !wantEditAge;
                          },
                          icon: const Icon(Icons.save))
                      : IconButton(
                          onPressed: () {
                            ref.read(wantEditAgeProvider.notifier).state =
                                !wantEditAge;
                          },
                          icon: const Icon(Icons.edit))
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              ref
                  .read(userInfoNotifierProvider.notifier)
                  .updateUser(name: 'New Name');
            },
            child: const Text('change name')),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('Setting')),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('Selling List')),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(firebaseAuthServiceProvider).signOut();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: const Text('Logout'),
        ),
      ],
    ),
  );
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
                onPressed: (){},
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
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => SignUpDialog(),
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
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Google button
              SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                  imagePath: 'assets/login_page_images/google.png'
              ),
              const SizedBox(width: 10,),
              //Apple button
              SquareTile(
                  onTap: () => AuthService().signInWithApple(),
                  imagePath: 'assets/login_page_images/apple.png'
              ),
              const SizedBox(width: 10,),
              //github button
              SquareTile(
                  onTap: () => AuthService().signInWithGithub(),
                  imagePath: 'assets/login_page_images/github.png'
              ),
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
