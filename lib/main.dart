import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

import 'core/domain/managers/db_manager.dart';
import 'di/injector.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/url_shortener/domain/models/url_alias.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  registerDependencies();

  final Directory dir = await getApplicationDocumentsDirectory();
  final DbManager<UrlAlias> db = injector.get();
  await db.initialize(dir.path);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Shortener',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const HomePage(),
    );
  }
}
