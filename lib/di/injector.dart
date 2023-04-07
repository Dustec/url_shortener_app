import 'package:get_it/get_it.dart';

import '../core/domain/managers/db_manager.dart';
import '../core/domain/managers/http_manager.dart';
import '../features/url_shortener/db/url_shortener_db_source.dart';
import '../features/url_shortener/domain/models/url_alias.dart';
import '../features/url_shortener/domain/repositories.dart/url_shortener_repository.dart';
import '../features/url_shortener/domain/sources/url_shortener_source.dart';
import '../features/url_shortener/remote/url_shortener_remote_source.dart';
import '../integrations/db_hive_manager.dart';
import '../integrations/http_dio_manager.dart';

final GetIt injector = GetIt.asNewInstance();

void registerDependencies() {
  injector.registerFactory<HttpManager>(() => HttpDioManager());
  injector.registerLazySingleton<DbManager<UrlAlias>>(() => DbHiveManager());

  injector.registerFactory<UrlShortenerSource>(
      () => UrlShortenerDbSource(dbManager: injector.get()),
      instanceName: 'UrlShortenerDbSource');

  injector.registerFactory<UrlShortenerSource>(
      () => UrlShortenerRemoteSource(httpManager: injector.get()),
      instanceName: 'UrlShortenerRemoteSource');

  injector.registerFactory<UrlShortenerRepository>(
    () => UrlShortenerDataRepository(
      dbSource: injector.get(instanceName: 'UrlShortenerDbSource'),
      remoteSource: injector.get(instanceName: 'UrlShortenerRemoteSource'),
    ),
  );
}
