import 'package:blueberry_flutter_template/providers/ProfileDetailScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDetailWidget extends ConsumerWidget {
  const ProfileDetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(ProfileDetailScreenProvider);
    return Center(
      child: GestureDetector(
        onTap: profileImage,
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: profileImage,
              ),
              const SizedBox(height: 20),
              const Text(
                'Profile Photo',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    ),
  }
}
