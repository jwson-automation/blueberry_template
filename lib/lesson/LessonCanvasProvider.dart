import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lessonCanvasProvider = StreamProvider<List<Map<String, Offset>>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('lines')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      double startX = doc['startX'] ?? 0.0;
      double startY = doc['startY'] ?? 0.0;
      double endX = doc['endX'] ?? 0.0;
      double endY = doc['endY'] ?? 0.0;
      return {
        'start': Offset(startX, startY),
        'end': Offset(endX, endY),
      };
    }).toList();
  });
});
