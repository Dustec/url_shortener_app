import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_shortener_app/features/url_list/presentation/cubit/snack_bar_handler.dart';
import 'package:url_shortener_app/features/url_list/presentation/cubit/url_list_cubit.dart';
import 'package:url_shortener_app/features/url_shortener/domain/repositories.dart/url_shortener_repository.dart';
import 'url_list_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  UrlShortenerRepository,
  SnackBarHandler,
])
void main() {
  group('UrlListCubitTest', () {
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

    test('initialize', () async {
      when(repo.getSavedUrls()).thenAnswer((_) => Stream.value([]));
      final UrlListCubit cubit = buildCubit();

      await Future.delayed(Duration.zero);

      expect(cubit.state.showFullLoader, false);
      expect(cubit.state.recentUrlsList, []);
    });

    test('default error handling', () async {
      when(repo.getSavedUrls()).thenAnswer((_) => Stream.error(Exception()));
      buildCubit();
      await Future.delayed(Duration.zero);

      verify(snackBarHandler.showSnackBar('Something went wrong.')).called(1);
      verifyNoMoreInteractions(snackBarHandler);
    });
  });
}
