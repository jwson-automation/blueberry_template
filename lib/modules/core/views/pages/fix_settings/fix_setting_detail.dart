import 'dart:io';
import 'package:blueberry_flutter_template/modules/core/providers/firebase/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/firebase/FirebaseStoreServiceProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/firebase/fireStorageServiceProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/user/ProfileImageProvider.dart';
import 'package:blueberry_flutter_template/modules/core/providers/user/UserInfoProvider.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_setting_bottom_modal.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/mypage/MyPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class buildUserDetails extends ConsumerStatefulWidget {
  buildUserDetails({super.key});


  @override
  ConsumerState<buildUserDetails> createState() => _buildUserDetailsState();
}

class _buildUserDetailsState extends ConsumerState<buildUserDetails> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userInfoNotifierProvider);
    final profileImage = ref.watch(profileImageStreamProvider);

    final wantEditName = ref.watch(wantEditNameProvider);
    final wantEditAge = ref.watch(wantEditAgeProvider);


    TextEditingController _nameController =
    TextEditingController(text: user.name);
    TextEditingController _ageController =
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
                child:
                kIsWeb ?
                Container(
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
                ) :
                IconButton(
                  onPressed: (){
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
                        }
                    );
                  },
                  icon: const Icon(Icons.upload_file),
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_nameController) {
                          ref
                              .read(userInfoNotifierProvider.notifier)
                              .updateUser(name: _nameController);
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
                              .updateUser(name: _nameController.text);
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
                        controller: _ageController,
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
                              .updateUser(
                              age: int.parse(_ageController.text));
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
}

Widget _uploadProfileImageButtons(FirestoreService firestoreService,
    FirebaseStorageService firebaseStorageService, BuildContext context){
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  return IconButton(
      onPressed: () async{
        try {
          var imageUrl = '';

          if (kIsWeb){
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
          if (!kIsWeb){
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

        } catch(e) {

        }
      },
      icon: Icon(Icons.settings)
  );
}