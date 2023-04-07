abstract class DbManager<T> {
  Future<void> initialize(String path);
  List<T> getSavedItems();
  void saveItem(T item);
  void deleteItem(T item);
  void clear();
}
