import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/camera/FirebaseStoreServiceProvider.dart';
import '../../../providers/camera/fireStorageServiceProvider.dart';
import '../../../providers/camera/PageProvider.dart';
import '../../../providers/user/ProfileImageProvider.dart';
import '../../../providers/user/UserInfoProvider.dart';

class SharePostScreen extends ConsumerWidget {
  final File imageFile;

  const SharePostScreen(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoNotifierProvider);
    final profileImage = ref.watch(profileImageStreamProvider);
    final storage = ref.read(fireStorageServiceProvider);
    final fireStorage = ref.read(firebaseStoreServiceProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final pageNotifier = ref.watch(pageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 이미지 편집'),
      ),
      body: Center(
        child: Column(
          children: [
            ClipOval(
              child: Image.file(
                imageFile,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  var imageUrl = '';

                  imageFile.readAsBytes().then((value) async {
                    imageUrl = await storage.uploadImageFromApp(
                        File(imageFile.path), ImageType.profileimage,
                        fixedFileName: userId);
                    fireStorage.createProfileIamge(userId, imageUrl);
                    pageNotifier.moveToPage(0);
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('이미지 저장 하기'),
            ),
          ],
        ),
      ),
    );
  }
}
