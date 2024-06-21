import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inforce_task/features/details/details.dart';
import 'package:inforce_task/models/book_model.dart';

class BookListItem extends StatelessWidget {
  final BookModel book;
  final VoidCallback onDelete;

  const BookListItem({required this.book, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreen(book: book),
          ),
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            title: Text(
              book.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(book.publicationYear),
          ),
        ),
      ),
    );
  }
}
