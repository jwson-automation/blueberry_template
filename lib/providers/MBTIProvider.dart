import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/mbti/MBTIHomeWidget.dart';

final mbtiProvider = StateNotifierProvider<MBTINotifier, MBTIType>((ref) {
  return MBTINotifier(MBTIType.NULL);
});

class MBTINotifier extends StateNotifier<MBTIType> {
  MBTINotifier(super.state);

  List<int> _mbtiScore = [0, 0, 0, 0];

  void initScore() {
    _mbtiScore = [0, 0, 0, 0];
  }

  void setMBTI() {
    int type = 0;
    if (_mbtiScore[0] >= 0) type += 8;
    if (_mbtiScore[1] >= 0) type += 4;
    if (_mbtiScore[2] >= 0) type += 2;
    if (_mbtiScore[3] >= 0) type += 1;

    state = MBTIType.values[type];
  }

  void updateScore(String type, int addition) {
    switch (type) {
      case "E":
        _mbtiScore[0] += addition;
        break;
      case "I":
        _mbtiScore[0] -= addition;
        break;
      case "S":
        _mbtiScore[1] += addition;
        break;
      case "N":
        _mbtiScore[1] -= addition;
        break;
      case "T":
        _mbtiScore[2] += addition;
        break;
      case "F":
        _mbtiScore[2] -= addition;
        break;
      case "J":
        _mbtiScore[3] += addition;
        break;
      case "P":
        _mbtiScore[3] -= addition;
        break;
    }
  }
}

final mbtiQuestionProvider = StreamProvider<List<MBTIQuestionModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('mbtiQuestions').snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => MBTIQuestionModel(
              question: doc['Question'] as String,
              type: doc['Type'] as String,
              imageUrl: doc['ImageUrl'] as String,
            ))
        .toList();
  });
});

Future<String> fetchMBTIImageUrl(String imageName) async {
  final ref = FirebaseStorage.instance.ref('mbti-question/$imageName.webp');
  return await ref.getDownloadURL();
}

final mbtiImageProvider =
    FutureProvider.family<String, String>((ref, imageName) async {
  return await fetchMBTIImageUrl(imageName);
});
