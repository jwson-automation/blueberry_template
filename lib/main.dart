import 'package:app_links/app_links.dart';
import 'package:blueberry_flutter_template/globals.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/mypage/PasswordResetPage.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// CI Test 환경에서는 Firebase 초기화를 하지 않음
import 'firebase_options.dart';

import 'modules/core/notification/firebase_cloud_messaging_manager.dart';
import 'modules/core/providers/ThemeProvider.dart';
import 'modules/core/utils/AppStrings.dart';
import 'modules/core/utils/AppTheme.dart'; // 수정된 AppTheme.dart 파일 import
import 'modules/core/utils/ResponsiveLayoutBuilder.dart';
import 'modules/core/views/home/TopPage.dart';
import 'modules/core/views/splashScreen/SplashScreen.dart'; // SplashScreen import

Future<void> main() async {
  OpenAI.apiKey = ""; // OpenAI API Key를 넣어주세요.
  WidgetsFlutterBinding.ensureInitialized();

  if (!const bool.fromEnvironment('CI')) {
    // CI 테스트 환경이 아닐 때만 Firebase 초기화
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseCloudMessagingManager.initialize();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb == false) {
      final appLinks = AppLinks(); // AppLinks is singleton

      /// Subscribe to all events (initial link and further)
      appLinks.uriLinkStream.listen((uri) {
        if (uri.queryParameters['mode'] == 'resetPassword') {
          Navigator.of(navigatorKey.currentState!.context).push(
            MaterialPageRoute(
              builder: (context) => PasswordResetPage(
                params: uri.queryParameters,
              ),
            ),
          );
        }
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // ThemeProvider를 구독하여 다크모드 상태를 가져옴
          final themeMode = ref.watch(themeNotifierProvider);

          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            // 라이트 모드 테마 설정
            theme: lightTheme,
            // 다크 모드 테마 설정
            darkTheme: darkTheme,
            // 현재 테마 모드 설정
            themeMode: themeMode,
            // 플랫폼에 따른 초기 화면 설정(web은 스플래쉬스크린 없음)
            home: kIsWeb
                ? ResponsiveLayoutBuilder(
                    context,
                    const TopPage(),
                  )
                : const SplashScreen(),
          );
        },
      ),
    );
  }
}
