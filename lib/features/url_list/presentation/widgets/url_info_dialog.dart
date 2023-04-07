import 'package:flutter/material.dart';
import 'package:url_shortener_app/features/url_shortener/domain/models/url_alias.dart';

class UrlInfoDialog extends StatelessWidget {
  const UrlInfoDialog({
    Key? key,
    required this.urlAlias,
  }) : super(key: key);

  final UrlAlias urlAlias;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      title: Text('ALIAS: ${urlAlias.alias}'),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('ORIGINAL:'),
            const SizedBox(height: 4),
            Text(
              urlAlias.original,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text('SHORT:'),
            const SizedBox(height: 4),
            Text(
              urlAlias.short,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
