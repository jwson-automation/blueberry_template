import 'dart:io';

import 'package:blueberry_flutter_template/screens/mypage/camera/setting_inside_account_manager.dart';
import 'package:blueberry_flutter_template/screens/mypage/camera/setting_inside_camera_media.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_engine/easy_engine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/camera/FirebaseStoreServiceProvider.dart';
import '../../providers/camera/fireStorageServiceProvider.dart';
import '../../providers/user/FirebaseAuthServiceProvider.dart';
import '../../providers/user/ProfileImageProvider.dart';
import '../../widgets/CustomDividerWidget.dart';
import '../SettingScreen.dart';
import 'camera/SettingsBottomSheet.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(profileImageStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                profileImageStack(profileImage, ref, context),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "userID or userNickName",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("Google 로그인을 사용 중 입니다.")
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FixSettingAccountManager(),
                ));
              },
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "관리",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.card_membership),
                title: Text(
                  "결제 정보",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.alarm_add_outlined),
                title: Text(
                  "알림",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.lock),
                title: Text(
                  "개인 / 보안",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(Icons.monitor),
                title: Text(
                  "테마",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FixSettingCameraMediaPage(),
                ));
              },
              child: const ListTile(
                leading: Icon(Icons.chat_bubble_outline),
                title: Text(
                  "채팅 / 미디어",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomDividerWidget(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingScreen();
                }));
              },
              child: const ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  "설정",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const CustomDividerWidget(),

            //Logout button
            GestureDetector(
              onTap: () {
                ref.read(firebaseAuthServiceProvider).signOut();
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "로그아웃",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            //Logout button
            GestureDetector(
              onTap: () async {
                try {
                  final re = await engine.deleteAccount();
                  debugPrint(re.toString());
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('회원탈퇴가 완료되었습니다.'),
                      ),
                    );
                  }
                  ref.read(firebaseAuthServiceProvider).signOut();
                } on FirebaseFunctionsException catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.code}/${e.message}'),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Error: $e'), // e.code: internal, e.message: INTERNAL
                      ),
                    );
                  }
                }
              },
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.person_off),
                title: Text(
                  "회원탈퇴",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Stack profileImageStack(
      AsyncValue<String> profileImage, WidgetRef ref, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        profileImage.when(
          data: (imageUrl) => Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, _, __) {
                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                );
              },
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: kIsWeb
              ? Container(
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
                    context,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: const SizedBox(
                              height: 150,
                              child: SettingsBottomSheet(),
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.upload_file),
                ),
        ),
      ],
    );
  }
}

Widget _uploadProfileImageButtons(FirestoreService firestoreService,
    FirebaseStorageService firebaseStorageService, BuildContext context) {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return IconButton(
    onPressed: () async {
      try {
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
      } catch (e) {}
    },
    icon: const Icon(Icons.settings),
  );
}

