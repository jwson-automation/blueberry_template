import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user/ProfileImageProvider.dart';

class MiniAvatar extends ConsumerWidget {
  const MiniAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(profileImageStreamProvider);

    return Center(
      child: profileImage.when(
          data: (imageUrl) => CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
          )
      ),
    );
  }
}
