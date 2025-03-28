import 'package:flutter/material.dart';
import 'package:picassostore/utils/prefs.dart';

final  Payments = {
  1: locale().cash,
  2: locale().card,
  3: locale().bank
};

Future<int?> showPaymentDialog(BuildContext context) async {
  return showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(locale().choosePayment),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(context, locale().cash, 1),
            _buildOption(context, locale().card, 2),
            _buildOption(context, locale().bank, 3),
          ],
        ),
      );
    },
  );
}

Widget _buildOption(BuildContext context, String option, int result) {
  return ListTile(
    title: Text(option),
    onTap: () => Navigator.of(context).pop(result),
  );
}
