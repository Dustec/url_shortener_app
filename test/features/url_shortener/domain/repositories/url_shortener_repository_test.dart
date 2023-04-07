import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_shortener_app/features/url_shortener/domain/repositories.dart/url_shortener_repository.dart';
import 'package:url_shortener_app/features/url_shortener/domain/sources/url_shortener_source.dart';
import 'url_shortener_repository_test.mocks.dart';

@GenerateMocks(<Type>[
  UrlShortenerSource,
])
void main() {
  group('UrlShortenerRepositoryTest', () {
    final MockUrlShortenerSource dbSource = MockUrlShortenerSource();
    final MockUrlShortenerSource remoteSource = MockUrlShortenerSource();

    UrlShortenerDataRepository buildRepository() {
      return UrlShortenerDataRepository(
        dbSource: dbSource,
        remoteSource: remoteSource,
      );
    }

    setUp(() {
      reset(dbSource);
      reset(remoteSource);
    });

    test('clearRecentUrls', () {
      final UrlShortenerDataRepository repo = buildRepository();
      repo.clearRecentUrls();

      verify(dbSource.clear()).called(1);
      verifyNoMoreInteractions(dbSource);
      verifyZeroInteractions(remoteSource);
    });
  });
}
