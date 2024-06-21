import 'package:inforce_task/models/book_model.dart';

abstract class AbstractBookRepository {
  Future<List<BookModel>> fetchAllBooks();
}