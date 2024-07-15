// // AdminScreen.dart
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../modules/core/providers/firebase/FirebaseStoreServiceProvider.dart';
// import '../../modules/core/providers/firebase/fireStorageServiceProvider.dart';
// import '../../modules/core/utils/AppStrings.dart';
// import 'UploadEventDialog.dart';
// import 'UploadItemDialog.dart';
//
// /**
//  * AdminScreen.dart
//  *
//  * Admin Page
//  * - 관리자 페이지
//  * - 임시 데이터 생성 및 업로드를 위한 화면
//  *
//  * @jwson-automation
//  */
//
// class AdminScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final firestoreService = ref.watch(firebaseStoreServiceProvider);
//     final firebaseStorageService = ref.watch(fireStorageServiceProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(AppStrings.adminPageTitle),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _makeTmpUserButtons(firestoreService, context),
//             const SizedBox(height: 20),
//             _makeTmpItemButtons(firestoreService, context),
//             const SizedBox(height: 20),
//             _makeChatButtons(firestoreService, context),
//             const SizedBox(height: 20),
//             _uploadBannerImageButtons(
//                 firestoreService, firebaseStorageService, context),
//             const SizedBox(height: 20),
//             _makeItemButtons(firestoreService, firebaseStorageService, context),
//             const SizedBox(height: 20),
//             _makeEventButtons(
//                 firestoreService, firebaseStorageService, context),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget _makeEventButtons(FirestoreService firestoreService,
//     FirebaseStorageService firebaseStorageService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       try {
//         await showDialog(
//           context: context,
//           builder: (context) => UploadEventDialog(
//               firestoreService: firestoreService,
//               firebaseStorageService: firebaseStorageService),
//         );
//         showSuccessDialog(context, '등록되었습니다!');
//       } catch (e) {
//         print('Failed to upload event: $e');
//         showErrorDialog(context, '이벤트 업로드에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.uploadEventButtonLabel),
//   );
// }
//
// Widget _makeItemButtons(FirestoreService firestoreService,
//     FirebaseStorageService firebaseStorageService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       try {
//         await showDialog(
//           context: context,
//           builder: (context) => UploadItemDialog(
//               firestoreService: firestoreService,
//               firebaseStorageService: firebaseStorageService),
//         );
//         showSuccessDialog(context, '등록되었습니다!');
//       } catch (e) {
//         print('Failed to upload item: $e');
//         showErrorDialog(context, '아이템 업로드에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.uploadItemButtonLabel),
//   );
// }
//
// Widget _makeChatButtons(
//     FirestoreService firestoreService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       try {
//         var chatDto = ChatDTO(
//             chatId: 'chat001',
//             senderId: 'user001',
//             message: 'Hello World!',
//             timestamp: DateTime.now());
//         await firestoreService.createChat(chatDto);
//         showSuccessDialog(context, '등록되었습니다!');
//       } catch (e) {
//         print('Failed to create chat: $e');
//         showErrorDialog(context, '채팅 생성에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.makeChatButtonLabel),
//   );
// }
//
// Widget _uploadBannerImageButtons(FirestoreService firestoreService,
//     FirebaseStorageService firebaseStorageService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       try {
//         var imageUrl = '';
//         if (kIsWeb) {
//           final ImagePicker _picker = ImagePicker();
//           final XFile? image =
//               await _picker.pickImage(source: ImageSource.gallery);
//
//           image?.readAsBytes().then((value) async {
//             imageUrl = await firebaseStorageService.uploadImageFromWeb(
//                 value, ImageType.banner,
//                 fixedFileName: 'MainBanner.jpg');
//
//             var bannerDto = BannerDTO(itemId: 'banner', imageUrl: imageUrl);
//             firestoreService.createBanner(bannerDto);
//           });
//         }
//         if (!kIsWeb) {
//           final pickedFile =
//               await ImagePicker().pickImage(source: ImageSource.gallery);
//           if (pickedFile != null) {
//             imageUrl = await firebaseStorageService.uploadImageFromApp(
//                 File(pickedFile.path), ImageType.banner,
//                 fixedFileName: 'MainBanner.jpg');
//
//             var bannerDto = BannerDTO(itemId: 'banner', imageUrl: imageUrl);
//             await firestoreService.createBanner(bannerDto);
//           }
//         }
//
//         if (imageUrl != '') {
//           var bannerDto = BannerDTO(itemId: 'banner', imageUrl: imageUrl);
//           await firestoreService.createBanner(bannerDto);
//           showSuccessDialog(context, '등록되었습니다!');
//         } else {
//           throw Exception('Cancel to upload image');
//         }
//       } catch (e) {
//         print('Failed to create banner: $e');
//         showErrorDialog(context, '배너 업로드에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.uploadBannerButtonLabel),
//   );
// }
//
// Widget _makeTmpItemButtons(
//     FirestoreService firestoreService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       try {
//         var itemDto = ItemDTO(
//             itemId: 'item001',
//             title: 'New Chair',
//             originalPrice: 100,
//             discountedPrice: 80,
//             description: 'A very comfortable chair',
//             imageUrl: '',
//             category: 'Furniture',
//             isMainListView: true,
//             isMainGridView: true,
//             productTitle: 'sample product title',
//             productDescription: 'sample product description');
//         await firestoreService.createItem(itemDto);
//         showSuccessDialog(context, '등록되었습니다!');
//       } catch (e) {
//         print('Failed to create item: $e');
//         showErrorDialog(context, '아이템 생성에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.makeItemButtonLabel),
//   );
// }
//
// Widget _makeTmpUserButtons(
//     FirestoreService firestoreService, BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       print('Creating user info...');
//       try {
//         var userDto = UserDTO(
//             userId: 'user001',
//             name: 'John Doe',
//             email: 'john@example.com',
//             age: 30,
//             profileImageUrl: '');
//         await firestoreService.createUser(userDto);
//         showSuccessDialog(context, '등록되었습니다!');
//       } catch (e) {
//         print('Failed to create user: $e');
//         showErrorDialog(context, '사용자 생성에 실패했습니다.');
//       }
//     },
//     child: const Text(AppStrings.makeUserButtonLabel),
//   );
// }
