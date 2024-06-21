import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inforce_task/db/hive_repository.dart';
import 'package:inforce_task/models/book_model.dart';
import 'package:inforce_task/repositories/book_repository.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  SortBy _currentSortBy = SortBy.title;

  BooksBloc() : super(BooksInitial()) {
    on<LoadBooks>((event, emit) async {
      emit(BooksLoading());

      try {
        List<BookModel> books = HiveRepository().getAllBooks();

        if (books.isEmpty) {
          books = await BookRepository().fetchAllBooks();
          _sortBooks(books);
          HiveRepository().addBooks(books);
        }
        _sortBooks(books);
        emit(BooksLoaded(books: books));
      } catch (e) {
        emit(BooksLoadingFailure(exception: e));
      }
    });

    on<AddBook>((event, emit) async {
      try {
        emit(BooksLoading());
        HiveRepository().addBook(event.book);
        List<BookModel> books = HiveRepository().getAllBooks();
        _sortBooks(books);
        emit(BooksLoaded(books: books));
      } catch (e) {
        emit(BooksLoadingFailure(exception: e));
      }
    });

    on<DeleteBook>((event, emit) async {
      try {
        emit(BooksLoading());
        HiveRepository().deleteBook(event.book);
        List<BookModel> books = HiveRepository().getAllBooks();
        _sortBooks(books);
        emit(BooksLoaded(books: books));
      } catch (e) {
        emit(BooksLoadingFailure(exception: e));
      }
    });

    on<SortBooks>((event, emit) async {
      _currentSortBy = event.sortBy;
      if (state is BooksLoaded) {
        final currentState = state as BooksLoaded;
        List<BookModel> sortedBooks = List<BookModel>.from(currentState.books);
        _sortBooks(sortedBooks);
        emit(BooksLoaded(books: sortedBooks));
      }
    });
  }

  void _sortBooks(List<BookModel> books) {
    if (_currentSortBy == SortBy.title) {
      books.sort((a, b) => a.title.compareTo(b.title));
    } else if (_currentSortBy == SortBy.count) {
      books.sort((a, b) => a.title.length.compareTo(b.title.length));
    }
  }
}
