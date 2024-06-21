import 'package:inforce_task/models/book_model.dart';

abstract class AbstractHiveRepository {
  Future<void> initHive();
  void addBook(BookModel bookModel);
  void deleteBook(BookModel bookModel);
  void addBooks(List<BookModel> bookModels);
  List<BookModel> getAllBooks();
}
