import 'package:blueberry_flutter_template/model/MBTIModel.dart';
import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mbtiProvider = StateNotifierProvider<MBTINotifier, MBTIType>((ref) {
  return MBTINotifier(MBTIType.NULL);
});

class MBTINotifier extends StateNotifier<MBTIType> {
  MBTINotifier(super.state);

  void setMBTI(MBTIType mbti) {
    state = mbti;
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
