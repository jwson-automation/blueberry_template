import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenceStorage {
  final _storage = const FlutterSecureStorage();

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: IOSAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() => AndroidOptions();

  Future<String?> readString(String key) {
    return _storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<int?> readInt(String key) async {
    final value = await readString(key) ?? '';
    return int.tryParse(value);
  }

  Future<bool> readBool(String key) async {
    final value = await readString(key) ?? 'false';
    return bool.tryParse(value) ?? false;
  }

  Future<void> write(String key, dynamic value) {
    final response = _storage.write(
      key: key,
      value: value?.toString(),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return response;
  }

  Future<void> clear() {
    return _storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<void> delete(String key) async {
    _storage.delete(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<bool> contains(String key) {
    return _storage.containsKey(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}
