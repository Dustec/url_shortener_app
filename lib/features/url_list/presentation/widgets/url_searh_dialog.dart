import 'package:flutter/material.dart';

class UrlSearchDialog extends StatefulWidget {
  const UrlSearchDialog({Key? key}) : super(key: key);

  @override
  State<UrlSearchDialog> createState() => _UrlSearchDialogState();
}

class _UrlSearchDialogState extends State<UrlSearchDialog> {
  late final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      title: const Text('Do you have an alias?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Type it here!',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pop(_textController.text.trim()),
          child: const Text('Search'),
        ),
      ],
    );
  }
}
