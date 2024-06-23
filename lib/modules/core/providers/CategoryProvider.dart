import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * CategoryProvider.dart
 *
 * Category Provider
 * - 카테고리 리스트를 관리하는 StateProvider
 *
 * @jwson-automation
 */

// 카테고리 리스트를 관리하는 StateProvider
final categoryProvider = StateProvider<List<String>>((ref) {
  return ['Electronics', 'Clothing', 'Books', 'Home Appliances'];
});
