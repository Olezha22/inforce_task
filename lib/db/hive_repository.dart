import 'package:hive_flutter/hive_flutter.dart';
import 'package:inforce_task/db/abstract_hive_repository.dart';
import 'package:inforce_task/models/book_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveRepository implements AbstractHiveRepository {
  @override
  Future<void> initHive() async {
    final applicationDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(applicationDocumentDir.path);
    Hive.registerAdapter(BookModelAdapter());

    await Hive.openBox<BookModel>('books');
  }

  @override
  void addBook(BookModel bookModel) {
    Hive.box<BookModel>('books').add(bookModel);
  }

  @override
  void deleteBook(BookModel bookModel) {
    final box = Hive.box<BookModel>('books');
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.id == bookModel.id,
      orElse: () => null,
    );

    if (key != null) {
      box.delete(key);
    }
  }

  @override
  void addBooks(List<BookModel> bookModels) {
    var box = Hive.box<BookModel>('books');
    for (var book in bookModels) {
      box.add(book);
    }
  }

  @override
  List<BookModel> getAllBooks() {
    return Hive.box<BookModel>('books').values.toList();
  }
}
