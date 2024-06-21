part of 'books_bloc.dart';

abstract class BooksState extends Equatable {}

class BooksInitial extends BooksState {
  @override
  List<Object?> get props => [];
}

class BooksLoading extends BooksState {
  @override
  List<Object?> get props => [];
}

class BooksLoaded extends BooksState {
  final List<BookModel> books;

  BooksLoaded({required this.books});

  @override
  List<Object> get props => [books];
}

class BooksLoadingFailure extends BooksState {
  BooksLoadingFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
