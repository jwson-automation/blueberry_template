import 'package:blueberry_flutter_template/globals.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/mypage/PasswordResetPage.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'modules/core/utils/AppStrings.dart';
import 'modules/core/utils/AppTheme.dart';
import 'modules/core/utils/ResponsiveLayoutBuilder.dart';
import 'modules/core/views/home/TopPage.dart';
import 'package:app_links/app_links.dart';

Future<void> main() async {
  OpenAI.apiKey = ""; // OpenAI API Key를 넣어주세요.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
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
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: appTheme,
      home: ResponsiveLayoutBuilder(
        context,
        const TopPage(),
      ),
    );
  }
}
