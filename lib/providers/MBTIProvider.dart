import 'package:blueberry_flutter_template/model/MBTIModel.dart';
import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mbtiProvider = StateNotifierProvider<MBTINotifier, MBTIType>((ref) {
  return MBTINotifier(MBTIType.NULL);
});

class MBTINotifier extends StateNotifier<MBTIType> {
  MBTINotifier(super.state);

  int _eScore = 0;
  int _sScore = 0;
  int _tScore = 0;
  int _jScore = 0;

  void initScore() {
    _eScore = 0;
    _sScore = 0;
    _tScore = 0;
    _jScore = 0;
  }

  void setMBTI() {
    int type = 0;
    if (_eScore >= 0) type += 8;
    if (_sScore >= 0) type += 4;
    if (_tScore >= 0) type += 2;
    if (_jScore >= 0) type += 1;
    state = MBTIType.values[type];
  }

  void updateScore(String type, int addition) {
    switch (type) {
      case "E":
        _eScore += addition;
        break;
      case "I":
        _eScore -= addition;
        break;
      case "S":
        _sScore += addition;
        break;
      case "N":
        _sScore -= addition;
        break;
      case "T":
        _tScore += addition;
        break;
      case "F":
        _tScore -= addition;
        break;
      case "J":
        _jScore += addition;
        break;
      case "P":
        _jScore -= addition;
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
