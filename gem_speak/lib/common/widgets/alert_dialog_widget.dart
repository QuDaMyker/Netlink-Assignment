import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(title: title, content: content);
      },
    );
  }
}
