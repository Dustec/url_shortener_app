import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injector.dart';
import '../cubit/url_list_cubit.dart';
import 'url_list_page.dart';

class UrlListProvider extends StatelessWidget {
  const UrlListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UrlListCubit>(
      create: (_) => UrlListCubit(
        urlShortenerRepository: injector.get(),
      ),
      child: const UrlListPage(),
    );
  }
}
