import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailDuplicateProvider = StateNotifierProvider<EmailDuplicateNotifier, EmailDuplicateState>((ref) {
  return EmailDuplicateNotifier();
});

class EmailDuplicateState {
  String? email;
  bool isDuplication = false;

  EmailDuplicateState({this.email, required this.isDuplication});
}

class EmailDuplicateNotifier extends StateNotifier<EmailDuplicateState> {
  EmailDuplicateNotifier() : super(EmailDuplicateState(isDuplication: false));

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isDuplication(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // 이메일이 이미 존재하는 경우
        state = EmailDuplicateState(email: email, isDuplication: true);
        return true;
      } else {
        // 이메일이 존재하지 않는 경우
        state = EmailDuplicateState(email: email, isDuplication: false);
        return false;
      }
    } catch(e){
      print('$e');
      state = EmailDuplicateState(email: email, isDuplication: false);
      return false;
    }
  }

}
