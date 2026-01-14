import 'package:flutter/material.dart';
import 'package:picassostore/utils/prefs.dart';

void showErrorDialog(String message) {
  final ctx = Prefs.navigatorKey.currentContext;
  if (ctx == null) return;

  showDialog(
    context: ctx,
    builder:
        (_) => AlertDialog(
      title: Text(locale().error),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Prefs.navigatorKey.currentState?.pop(),
          child: Text(locale().ok),
        ),
      ],
    ),
  );
}