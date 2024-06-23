import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'UserInfoProvider.dart';

/**
 * NicknameProvider.dart
 *
 * Nickname Provider
 * - 닉네임 데이터를 제공하는 Provider
 * - nicknameProvider: 닉네임 데이터 제공
 *
 * @jwson-automation
 */

final nicknameProvider = StateProvider<String>((ref) {
  // userProvider의 상태를 구독
  final userState = ref.watch(userDataLoadProvider);
  return userState.maybeWhen(data: (user) => user!.name, orElse: () => '익명');
});
