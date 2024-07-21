import 'package:flutter/material.dart';

import 'AppStrings.dart';

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(AppStrings.okButtonText),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text(AppStrings.okButtonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(AppStrings.errorTitle),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text(AppStrings.okButtonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
