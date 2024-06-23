import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'modules/core/utils/AppStrings.dart';
import 'modules/core/utils/AppTheme.dart';
import 'modules/core/utils/ResponsiveLayoutBuilder.dart';
import 'modules/core/views/home/TopPage.dart';

Future<void> main() async {
  OpenAI.apiKey = ""; // OpenAI API Key를 넣어주세요.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: appTheme,
        home: ResponsiveLayoutBuilder(context, TopPage()));
  }
}
