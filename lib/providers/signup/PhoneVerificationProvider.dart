// 휴대폰인증 provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 휴대폰인증 provider
final phoneNumberProvider = StateProvider<String>((ref) => '');
final verificationCodeProvider = StateProvider<String>((ref) => '');
final phoneVerificationProvider =
    NotifierProvider<PhoneVerificationNotifier, PhoneVerificationState>(() {
  return PhoneVerificationNotifier();
});

class PhoneVerificationNotifier extends Notifier<PhoneVerificationState> {
  @override
  PhoneVerificationState build() {
    return VerificationInitialize();
  }

  Future<bool> sendPhoneNumber(String phoneNumber) async {
    try {
      final verificationId = await getVerificationId(phoneNumber);
      state = VerificationCodeSent(verificationId);
      return true;
    } catch (e) {
      state = VerificationError(e.toString());
      return false;
    }
  }

  Future<bool> verifyCode(String code) async {
    if (state is VerificationCodeSent) {
      final verificationId = (state as VerificationCodeSent).verificationId;
      try {
        await verifyPhoneVerificationCode(verificationId, code);
        state = VerificationSuccess();
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }
}

// 휴대폰인증 상태관리 클래스
abstract class PhoneVerificationState {}

class VerificationInitialize extends PhoneVerificationState {
  final String phoneNumber;
  final String verificationNumber;

  VerificationInitialize({this.phoneNumber = '', this.verificationNumber = ''});
}

class VerificationCodeSent extends PhoneVerificationState {
  final String verificationId;

  VerificationCodeSent(this.verificationId);
}

class VerificationSuccess extends PhoneVerificationState {}

class VerificationError extends PhoneVerificationState {
  final String message;

  VerificationError(this.message);
}

// 휴대폰번호 전송 로직 (구현 필요)
Future<String> getVerificationId(String phoneNumber) async {
  // 에러테스트
  if (phoneNumber.length == 11) {
    return 'verificationId';
  }

  throw Exception("Invalid phone number");
}

// 인증번호 전송 로직 (구현 필요)
Future<bool> verifyPhoneVerificationCode(
    String verificationId, String code) async {
  if (verificationId == 'verificationId' && code == "123456") {
    return true;
  }

  throw Exception("Invalid verification code");
}
