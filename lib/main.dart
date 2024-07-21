import 'package:blueberry_flutter_template/screens/mypage/password/PasswordResetPage.dart';
import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/utils/ResponsiveLayoutBuilder.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'providers/ThemeProvider.dart';
import 'screens/SplashScreen.dart';
import 'utils/AppTheme.dart';

Future<void> main() async {
  OpenAI.apiKey = ""; // OpenAI API Key를 넣어주세요.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseCloudMessagingManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              const TopScreen(),
            )
                : const SplashScreen(),
          );
        },
      ),
    );
  }
}
