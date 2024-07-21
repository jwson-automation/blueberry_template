import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// FirebaseStorageService.dart
///
/// Firebase Storage Service
/// - Firebase Storage에 이미지 업로드 서비스
/// - uploadImageFromWeb(): 웹 이미지 업로드
/// - uploadImageFromApp(): 앱 이미지 업로드
///
/// @jwson-automation

enum ImageType {
  banner,
  profileimage,
  event,
  item,
  productImage,
  descriptionImage
}

final fireStorageServiceProvider = Provider<FirebaseStorageService>((ref) {
  return FirebaseStorageService();
});

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageFromWeb(Uint8List webImageFile, ImageType type,
      {String? fixedFileName}) async {
    try {
      // UUID를 사용하여 유니크한 파일 이름 생성
      var uuid = const Uuid();
      String fullPath = '';

      switch (type) {
        case ImageType.banner:
          fullPath = '${type.name}/$fixedFileName';
          break;
        case ImageType.profileimage:
          fullPath = '${type.name}/$fixedFileName';
          break;
        case ImageType.event:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.item:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.productImage:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.descriptionImage:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
      }

      final ref = _storage.ref().child(fullPath);
      await ref.putData(webImageFile);
      final url = await ref.getDownloadURL();
      print('Image uploaded successfully : $url');
      return url;
    } catch (e) {
      // Handle error
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image');
    }
  }

  Future<String> uploadImageFromApp(File appImageFile, ImageType type,
      {String? fixedFileName}) async {
    try {
      // UUID를 사용하여 유니크한 파일 이름 생성
      var uuid = const Uuid();

      String fullPath = '';
      switch (type) {
        case ImageType.banner:
          fullPath = '${type.name}/$fixedFileName';
          break;
        case ImageType.profileimage:
          fullPath = '${type.name}/$fixedFileName';
          break;
        case ImageType.event:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.item:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.productImage:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
        case ImageType.descriptionImage:
          String fileName = '${uuid.v4()}.jpg';
          fullPath = '${type.name}/$fileName';
          break;
      }

      final ref = _storage.ref().child(fullPath);
      await ref.putFile(appImageFile);
      final url = await ref.getDownloadURL();
      print('Image uploaded successfully_firebase_storage_service : $url');
      return url;
    } catch (e) {
      // Handle error
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image');
    }
  }
}
