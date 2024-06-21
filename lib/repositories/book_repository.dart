import 'package:dio/dio.dart';
import 'package:inforce_task/models/book_model.dart';
import 'package:inforce_task/repositories/abstract_book_repository.dart';

class BookRepository implements AbstractBookRepository {
  final String url = 'https://freetestapi.com/api/v1/books';

 @override
  Future<List<BookModel>> fetchAllBooks() async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((book) => BookModel.fromJson(book as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }
}
