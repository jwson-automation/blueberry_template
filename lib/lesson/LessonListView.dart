import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LessonListProvider.dart';

class LessonListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _list = ref.watch(lessonListProvider);

    return
      ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${_list[index]}'),
          );
        });
  }
}
