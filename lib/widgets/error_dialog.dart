import 'package:flutter/material.dart';

void showError(BuildContext ctx, String msg) {
  showDialog(
    context: ctx,
    builder: (_) => AlertDialog(
      title: const Text('Error'),
      content: Text(msg),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text('OK'))
      ],
    ),
  );
}
