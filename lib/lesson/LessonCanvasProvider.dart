import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lessonCanvasProvider = StreamProvider<List<Offset>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('points')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => Offset(doc['dx'], doc['dy'])).toList();
  });
});
