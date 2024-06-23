import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * BannerImageProvider.dart
 *
 * Banner Image Provider
 * - 배너 이미지 데이터를 제공하는 Provider
 * - fetchBannerImageUrlStream(): 배너 이미지 데이터 불러오기
 *
 * @jwson-automation
 */

Stream<String> fetchBannerImageUrlStream() {
  return FirebaseFirestore.instance
      .collection('banners')
      .doc('banner')
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists && snapshot.data()!.containsKey('imageUrl')) {
      return snapshot.data()!['imageUrl'] as String;
    } else {
      return 'default_banner_image_url'; // 문서 또는 필드가 없을 경우 기본 URL 제공
    }
  });
}

final bannerImageStreamProvider = StreamProvider<String>((ref) {
  return fetchBannerImageUrlStream();
});
