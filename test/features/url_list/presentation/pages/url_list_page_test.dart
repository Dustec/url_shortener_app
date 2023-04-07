import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_shortener_app/features/url_list/presentation/cubit/snack_bar_handler.dart';
import 'package:url_shortener_app/features/url_list/presentation/cubit/url_list_cubit.dart';
import 'package:url_shortener_app/features/url_list/presentation/page/url_list_page.dart';
import 'package:url_shortener_app/features/url_shortener/domain/models/url_alias.dart';
import 'package:url_shortener_app/features/url_shortener/domain/repositories.dart/url_shortener_repository.dart';

import '../../../../base/test_widget.dart';
import 'url_list_page_test.mocks.dart';

@GenerateMocks(<Type>[
  UrlShortenerRepository,
  SnackBarHandler,
])
void main() {
  group('UrlListPageTest', () {
    final MockUrlShortenerRepository repo = MockUrlShortenerRepository();
    final MockSnackBarHandler snackBarHandler = MockSnackBarHandler();

    UrlListCubit buildCubit() {
      return UrlListCubit(
        urlShortenerRepository: repo,
        snackBarHandler: snackBarHandler,
      );
    }

    setUp(() {
      reset(repo);
      reset(snackBarHandler);
    });

    testWidgets('pumpWidget', (tester) async {
      // Mock and Stubbing
      when(repo.getSavedUrls()).thenAnswer((_) => Stream.value(
            const [
              UrlAlias(
                alias: 'alias',
                short: 'short',
                original: 'original',
              ),
            ],
          ));
      // Set environment
      final UrlListCubit cubit = buildCubit();

      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider.value(
            value: cubit,
            child: const UrlListPage(),
          ),
        ),
      );
      await tester.pump();
      // Expects and verifies
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('alias'), findsOneWidget);
    });
  });
}
