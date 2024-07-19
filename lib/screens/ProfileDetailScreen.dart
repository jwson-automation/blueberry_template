import 'package:blueberry_flutter_template/widgets/ProfileDetailWidget.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    final List<String> images = [
      'assets/logo/logo_1.png',
      'assets/logo/logo_2.png',
      'assets/logo/logo_3.png',
    ];

    void nextImage() {
      currentIndex = (currentIndex + 1) % images.length;
    }

    return Scaffold(
      body: ProfileDetailWidget(),
    );
  }
}
