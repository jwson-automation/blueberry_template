import 'package:flutter/material.dart';

import '../../model/DogProfileModel.dart';

class ProfileScreen extends StatelessWidget {
  final DogProfileModel dogProfile;

  const ProfileScreen({super.key, required this.dogProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dogProfile.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              dogProfile.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dogProfile.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('성별: ${dogProfile.gender}'),
                  Text('종족: ${dogProfile.breed}'),
                  Text('사는 곳: ${dogProfile.location}'),
                  const SizedBox(height: 16),
                  const Text(
                    '소개',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(dogProfile.bio),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}