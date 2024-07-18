import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({
    super.key,
    required this.params,
  });

  final Map<String, String> params;

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final newPasswordController = TextEditingController();

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PasswordReset'),
      ),
      body: Column(
        children: [
          const Text("PasswordReset"),
          Text('oobCode: ${widget.params['oobCode']}'),
          Text('apikey: ${widget.params['apiKey']}'),
          Text('mode: ${widget.params['mode']}'),
          Text('continueUrl: ${widget.params['continueUrl']}'),
          TextField(
            controller: newPasswordController,
            decoration: const InputDecoration(labelText: 'New password'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.confirmPasswordReset(
                code: widget.params['oobCode']!,
                newPassword: newPasswordController.text,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password has been reset. Please sing-in with new password!',
                    ),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Reset password'),
          ),
        ],
      ),
    );
  }
}
