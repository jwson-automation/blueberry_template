import 'dart:io';

import 'package:blueberry_flutter_template/modules/core/providers/firebase/FirebaseStoreServiceProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/firebase/fireStorageServiceProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/page/page_provider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/user/ProfileImageProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/user/UserInfoProvider.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_settings_inside_page/setting_inside_account_manager.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_settings_inside_page/setting_inside_camera_media.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/mypage/SettingsBottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/firebase/FirebaseAuthServiceProvider.dart';
import '../../../widgets/CustomDivider.dart';
import '../setting/SettingPage.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(pageProvider);
    final loginState = ref.watch(loginStateProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);
    final user = ref.watch(userInfoNotifierProvider);
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
            SizedBox(
              height: 40,
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FixSettingAccountManager(),
                ));
              },
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "관리",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {},
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.card_membership),
                title: Text(
                  "결제 정보",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {},
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.alarm_add_outlined),
                title: Text(
                  "알림",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {},
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.lock),
                title: Text(
                  "개인 / 보안",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {},
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.monitor),
                title: Text(
                  "테마",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FixSettingCameraMediaPage(),
                ));
              },
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.chat_bubble_outline),
                title: Text(
                  "채팅 / 미디어",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomDivider(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingPage();
                }));
              },
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  "설정",
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
            const CustomDivider(),

            //Logout button
            GestureDetector(
              onTap: () {
                ref.read(firebaseAuthServiceProvider).signOut();
              },
              child: const Expanded(
                  child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "로그아웃",
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
                            child: Container(
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
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  return IconButton(
      onPressed: () async {
        try {
          var imageUrl = '';

          if (kIsWeb) {
            final ImagePicker _picker = ImagePicker();
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);

            image?.readAsBytes().then((value) async {
              imageUrl = await firebaseStorageService.uploadImageFromWeb(
                  value, ImageType.profileimage,
                  fixedFileName: _userId);

              firestoreService.createProfileIamge(_userId, imageUrl);
            });
          }
          if (!kIsWeb) {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              // 선택된 이미지를 Firebase Storage에 업로드
              imageUrl = await firebaseStorageService.uploadImageFromApp(
                  File(pickedFile.path), ImageType.profileimage,
                  fixedFileName: _userId);

              firestoreService.createProfileIamge(_userId, imageUrl);
            }
          }
          if (imageUrl != '') {
            print('Banner created successfully');
          } else {
            throw Exception('Cancel to upload image');
          }
        } catch (e) {}
      },
      icon: Icon(Icons.settings));
}
