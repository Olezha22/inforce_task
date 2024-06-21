import 'package:flutter/material.dart';
import 'package:inforce_task/features/details/widgets/widgets.dart';
import 'package:inforce_task/models/book_model.dart';

class DetailsScreen extends StatelessWidget {
  final BookModel book;

  const DetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: book.coverImage.isNotEmpty
                  ? Image.network(
                      book.coverImage,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.book,
                      size: 250,
                    ),
            ),
            const SizedBox(height: 16.0),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            DetailRow(
              icon: Icons.person,
              label: 'Author:',
              value: book.author,
            ),
            const SizedBox(height: 8.0),
            DetailRow(
              icon: Icons.calendar_today,
              label: 'Publication Year:',
              value: book.publicationYear,
            ),
            const SizedBox(height: 8.0),
            DetailRow(
              icon: Icons.category,
              label: 'Genre:',
              value: book.genre.join(', '),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              book.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
