import 'package:hive/hive.dart';

import '../core/domain/managers/db_manager.dart';
import '../features/url_shortener/domain/models/url_alias.dart';

part 'db_hive_manager.g.dart';

const String _savedUrlsBoxName = 'saved_urls';

class DbHiveManager implements DbManager<UrlAlias> {
  DbHiveManager();

  Box<SavedUrl>? _urlsBox;
  bool isInitialized = false;

  @override
  Future<void> initialize(String path) async {
    if (isInitialized) {
      return;
    }
    Hive
      ..init(path)
      ..registerAdapter(SavedUrlAdapter());

    await Hive.openBox<SavedUrl>(_savedUrlsBoxName);
    _urlsBox = Hive.box<SavedUrl>(_savedUrlsBoxName);

    isInitialized = true;
  }

  @override
  List<UrlAlias> getSavedItems() {
    assert(isInitialized, 'DbHiveManager not initialize');
    return (_urlsBox?.values ?? [])
        .map((e) => UrlAlias(
              alias: e.alias ?? '',
              short: e.urlShort ?? '',
              original: e.url ?? '',
            ))
        .toList();
  }

  @override
  void saveItem(UrlAlias item) {
    assert(isInitialized, 'DbHiveManager not initialize');
    _urlsBox?.put(
        item.alias,
        SavedUrl(
          alias: item.alias,
          url: item.original,
          urlShort: item.short,
        ));
  }

  @override
  void deleteItem(UrlAlias item) {
    assert(isInitialized, 'DbHiveManager not initialize');
    _urlsBox?.delete(item);
  }

  @override
  void clear() {
    assert(isInitialized, 'DbHiveManager not initialize');
    _urlsBox?.clear();
  }
}

@HiveType(typeId: 1)
class SavedUrl extends HiveObject {
  SavedUrl({
    required this.alias,
    required this.url,
    required this.urlShort,
  });

  @HiveField(1)
  String? alias;

  @HiveField(2)
  String? url;

  @HiveField(3)
  String? urlShort;
}
