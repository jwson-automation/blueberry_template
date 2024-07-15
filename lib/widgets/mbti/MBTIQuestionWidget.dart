import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user/FirebaseAuthServiceProvider.dart';

class MBTIQuestionWidget extends ConsumerWidget {
  const MBTIQuestionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _list = ref.watch(firebaseAuthServiceProvider).user;
    return _buildListView(["MBTI가 뭐에요?", "좋아하는 음식이 뭐에요?"]);
      // _list.when(
      //   data: (data) => _buildListView(data),
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (error, stackTrace) => Center(child: Text('Error: $error')));
  }
}

Widget _buildListView(List<String> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(data[index]),
      );
    },
  );
}
