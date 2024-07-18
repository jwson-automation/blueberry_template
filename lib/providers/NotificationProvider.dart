import 'package:blueberry_flutter_template/utils/FlutterSecureStorage.dart';
import 'package:blueberry_flutter_template/utils/StorageKeys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/notification/firebase_cloud_messaging_manager.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, bool>((ref) {
  return NotificationNotifier(false);
});

class NotificationNotifier extends StateNotifier<bool> {
  final _storage = PreferenceStorage();

  NotificationNotifier(super.state) {
    checkPermission();
  }

  // 권한 확인
  Future<void> checkPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted == false) return;

    _storage.readString(StorageKeys.fcmToken).then((value) {
      debugPrint('Saved fcmToken: $value');
      state = value != null && value.isNotEmpty;
    });
  }

  void setNotification(bool value) async {
    if (value == false) {
      FirebaseCloudMessagingManager.deleteToken();
      _storage.write(StorageKeys.fcmToken, '');
      state = false;
    } else {
      final status = await Permission.notification.status;

      if (status.isDenied) {
        await Permission.notification.request();
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      }

      if ((await Permission.notification.status).isGranted) {
        final token = await FirebaseCloudMessagingManager.getToken();

        debugPrint('fcmToken: $token');

        _storage.write(StorageKeys.fcmToken, token);
        state = true;
      }
    }
  }
}
