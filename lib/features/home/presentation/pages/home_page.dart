import 'package:flutter/material.dart';

import '../../../url_list/presentation/page/url_list_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UrlListProvider(),
    );
  }
}
