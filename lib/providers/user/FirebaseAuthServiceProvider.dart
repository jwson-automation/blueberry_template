import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FirebaseAuthServiceProvider.dart
///
/// Firebase Auth Service Provider
/// - FirebaseAuthService를 제공하는 Provider
/// - FirebaseAuthService: Firebase Auth 인증 서비스
/// - user: 사용자 상태 스트림
/// - signUpWithEmailPassword(): 이메일/비밀번호 회원가입
/// - signInWithEmailPassword(): 이메일/비밀번호 로그인
/// - signOut(): 로그아웃
/// - getCurrentUser(): 현재 로그인한 사용자 가져오기
/// - sendPasswordResetEmail(): 비밀번호 재설정 이메일 보내기
///
///  @jwson-automation

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(FirebaseAuth.instance);
});

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  // 사용자 상태 스트림
  Stream<User?> get user => _auth.authStateChanges();

  // 회원가입
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    } catch (e) {
      throw Exception('회원가입 실패: $e');
    }
  }

  // 이메일/비밀번호 로그인
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }

  // 현재 로그인한 사용자 가져오기
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // 비밀번호 재설정 이메일 보내기
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('비밀번호 재설정 이메일 전송 실패: $e');
    }
  }
}
