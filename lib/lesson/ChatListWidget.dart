import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ChatListProvider.dart';

class ChatListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _list = ref.watch(chatListProvider); // 로딩중인지, 제대로 들어온건지, 에러가 난건지

    return _list.when(
        data: (data) => _buildListView(data),
        // 정상적으로 들어왔을 때
        loading: () => const Center(child: CircularProgressIndicator()),
        // 로딩중일 때
        error: (error, stackTrace) =>
            Center(child: Text('Error: $error'))); // 에러가 발생했을 때
  }
}

Widget _buildListView(List<String> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(data[index]),
      );
    },
  );
}
