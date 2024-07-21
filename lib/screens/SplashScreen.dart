import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // kIsWeb 상수 사용
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ResponsiveLayoutBuilder.dart';

/// 작성일: 2024-07-01
/// 작성자: 오물개
/// 내용: 앱 초기화와 필수 자원 로딩을 관리하는 스플래쉬 스크린 구현

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // 현재 로딩 단계와 총 단계를 관리하는 변수들
  int _currentStep = 0;
  final int _totalSteps = 3;

  @override
  void initState() {
    super.initState();
    // 웹이 아닌 경우에만 초기화 함수 호출
    if (!kIsWeb) {
      _initializeApp();
    }
  }

  /// 앱 초기화를 단계별로 수행하는 함수
  Future<void> _initializeApp() async {
    try {
      // 단계별로 로딩 상태를 업데이트
      // 단계별 로딩은 사용하지 않음.
      // await _loadStep("Firebase 초기화", 1, _initializeFirebase);
      // await _loadStep("유저 정보 가져오기", 2, _fetchUserInfo);
      // await _loadStep("필수 데이터 로딩", 3, _loadEssentialData);

      // 스플레쉬 스크린 확인을 위한 3초 지연
      await Future.delayed(const Duration(seconds: 3));
      // 초기화 완료 후 메인 화면으로 전환
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ResponsiveLayoutBuilder(
                  context,
                  const TopScreen(),
                )),
      );
    } catch (e) {
      // 초기화 중 발생한 오류 처리
      print('초기화 오류: $e');
      // 필요 시 오류 화면으로 이동하거나 재시도 로직 추가 가능
    }
  }

  /// 각 단계별로 로딩 상태를 업데이트하고 작업을 수행하는 함수
  Future<void> _loadStep(String stepName, int stepNumber,
      Future<void> Function() stepFunction) async {
    setState(() {
      _currentStep = stepNumber;
    });
    await stepFunction();
  }

  /// Firebase 초기화 작업 (예시)
  Future<void> _initializeFirebase() async {
    await Future.delayed(const Duration(seconds: 1)); // 실제 작업을 대체하는 지연
  }

  /// 유저 정보 가져오는 작업 (예시)
  Future<void> _fetchUserInfo() async {
    // Firebase Auth를 사용하여 현재 유저 정보 가져오기
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(seconds: 1)); // 실제 작업을 대체하는 지연
    if (user == null) {
      // 예시: 유저 정보가 없는 경우 로그인 화면으로 이동 (여기서는 생략)
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => const LoginPage()),
      // );
    }
  }

  /// 필수 데이터 로딩 작업 (예시)
  Future<void> _loadEssentialData() async {
    // 필수 데이터 로딩 (여기서는 지연으로 대체)
    await Future.delayed(const Duration(seconds: 1)); // 실제 작업을 대체하는 지연
  }

  @override
  Widget build(BuildContext context) {
    // 웹인 경우 바로 홈 화면으로 이동
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const TopScreen()),
        );
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 모바일인 경우 스플래쉬 스크린 표시
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 앱 로고
            Image.asset(
              'assets/logo/logo_5.png', // 앱 로고 이미지 경로
              height: 150,
            ),
            const SizedBox(height: 20),
            // 로딩 애니메이션
            const CircularProgressIndicator(),
            // const SizedBox(height: 20),
            // // 로딩 상태 문구
            // Text(
            //   '$_currentStep/$_totalSteps 단계: '
            //   '${_currentStep == 1 ? 'Firebase 초기화 중...' : _currentStep == 2 ? '유저 정보 가져오는 중...' : '필수 데이터 로딩 중...'}',
            //   style: const TextStyle(fontSize: 16, color: Colors.black),
            // ),
          ],
        ),
      ),
    );
  }
}
