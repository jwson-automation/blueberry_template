import 'package:blueberry_flutter_template/modules/core/notification/firebase_cloud_messaging_manager.dart';
import 'package:blueberry_flutter_template/modules/core/storage/FlutterSecureStorage.dart';
import 'package:blueberry_flutter_template/modules/core/storage/StorageKeys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, bool>((ref) {
  return NotificationNotifier(false);
});

class NotificationNotifier extends StateNotifier<bool> {
  final _storage = PreferenceStorage();

  NotificationNotifier(super.state) {
    _storage.readString(StorageKeys.fcmToken).then((value) {
      debugPrint('fcmToken: $value');
      state = value != null;
    });
  }

  void setNotification(bool value) {
    state = value;
    if (value == false) {
      FirebaseCloudMessagingManager.deleteToken();
      _storage.delete(StorageKeys.fcmToken);
    } else {
      FirebaseCloudMessagingManager.getToken().then((token) {
        _storage.write(StorageKeys.fcmToken, token);
      });
    }
  }
}
