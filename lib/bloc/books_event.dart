part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {}

class LoadBooks extends BooksEvent {
  @override
  List<Object?> get props => [];
}

class AddBook extends BooksEvent {
  final BookModel book;

  AddBook(this.book);

  @override
  List<Object?> get props => [book];
}

class DeleteBook extends BooksEvent {
  final BookModel book;

  DeleteBook(this.book);

  @override
  List<Object?> get props => [book];
}

enum SortBy { title, count }

class SortBooks extends BooksEvent {
  final SortBy sortBy;

  SortBooks(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}


