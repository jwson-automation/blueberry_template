import 'package:flutter_riverpod/flutter_riverpod.dart';

final lessonListProvider = Provider<List<String>>((ref) {
  return ['item1', 'item2', 'item3'];
});