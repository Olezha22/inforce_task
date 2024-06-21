import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inforce_task/bloc/books_bloc.dart';
import 'package:inforce_task/features/data_list/widgets/widgets.dart';
import 'package:inforce_task/models/book_model.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  late BooksBloc _booksBloc;
  SortBy _sortBy = SortBy.title;

  @override
  void initState() {
    super.initState();
    _booksBloc = BooksBloc();
    _booksBloc.add(LoadBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data List"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<SortBy>(
              value: _sortBy,
              items: const [
                DropdownMenuItem(
                  value: SortBy.title,
                  child: Text("Sort by Title"),
                ),
                DropdownMenuItem(
                  value: SortBy.count,
                  child: Text("Sort by Count"),
                ),
              ],
              onChanged: (SortBy? value) {
                if (value != null) {
                  _sortBooks(value);
                }
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        bloc: _booksBloc,
        builder: (BuildContext context, BooksState state) {
          if (state is BooksLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BooksLoaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return BookListItem(
                  book: book,
                  onDelete: () {
                    _showDeleteConfirmationDialog(context, book);
                  },
                );
              },
            );
          }
          if (state is BooksLoadingFailure) {
            return Center(child: Text('${state.exception}'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: BlocBuilder<BooksBloc, BooksState>(
        bloc: _booksBloc,
        builder: (context, state) {
          if (state is BooksLoaded) {
            return FloatingActionButton(
              onPressed: _showAddBookDialog,
              backgroundColor: Colors.green.shade50,
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.black,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBookDialog(booksBloc: _booksBloc);
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, BookModel book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onConfirmed: () {
            _booksBloc.add(DeleteBook(book));
          },
        );
      },
    );
  }

  void _sortBooks(SortBy sortBy) {
    setState(() {
      _sortBy = sortBy;
    });
    _booksBloc.add(SortBooks(sortBy));
  }
}
