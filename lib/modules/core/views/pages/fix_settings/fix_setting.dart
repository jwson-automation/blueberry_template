import 'dart:io';
import 'package:blueberry_flutter_template/modules/core/providers/page/page_provider.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_setting_detail.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_setting_gallery.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_settings.design_sample.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_take_photo.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/mypage/SignUpDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';
import '../../../providers/user/ProfileImageProvider.dart';
import '../../../providers/user/UserInfoProvider.dart';
import '../../../providers/firebase/FirebaseAuthServiceProvider.dart';
import '../../../utils/AppStrings.dart';


final wantEditAgeProvider = StateProvider<bool>((ref) => false);
final wantEditNameProvider = StateProvider<bool>((ref) => false);


class MySettings extends ConsumerStatefulWidget {
  const MySettings({super.key});

  @override
  ConsumerState<MySettings> createState() => _MySettingsScreenState();
}


class _MySettingsScreenState extends ConsumerState<MySettings> {

  @override
  Widget build(BuildContext context) {
    final pageState = ref.watch(pageProvider);
    final loginState = ref.watch(loginStateProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myPageTitle),
        leading: kIsWeb ? null : pageState.pageNumber == 0 ? null
            : IconButton(
            onPressed: (){
              pageNotifier.moveToPAge(0);
            },
            icon: Icon(Icons.arrow_back)
        ),
      ),
      body: loginState.maybeWhen(
        data: (user) => user != null
            ? PageView(
            controller: pageState.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SettingsDesign(),
              TakePhoto(),
              ImageGallery(),
            ]
        )
            : _buildLogin(context, ref),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}





Widget _buildLogin(BuildContext context, WidgetRef ref) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: AppStrings.emailInputLabel,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.errorMessage_emptyEmail;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return AppStrings.errorMessage_invalidEmail;
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: AppStrings.passwordInputLabel,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.errorMessage_emptyPassword;
              }
              if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                  .hasMatch(value)) {
                return AppStrings.errorMessage_invalidPassword;
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                try {
                  await ref
                      .read(firebaseAuthServiceProvider)
                      .signInWithEmailPassword(email, password);
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(AppStrings.errorTitle),
                        content: Text('에러: $e'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(AppStrings.okButtonText),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text(AppStrings.loginButtonText),
          ),
          TextButton(
            onPressed: () =>
                showDialog(
                  context: context,
                  builder: (BuildContext context) => SignUpDialog(),
                ),
            child: Text(
              AppStrings.signUpButtonText,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    ),
  );
}
