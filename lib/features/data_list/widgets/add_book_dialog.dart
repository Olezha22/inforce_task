import 'package:flutter/material.dart';
import 'package:inforce_task/bloc/books_bloc.dart';
import 'package:inforce_task/models/book_model.dart';

class AddBookDialog extends StatefulWidget {
  final BooksBloc booksBloc;

  const AddBookDialog({required this.booksBloc, super.key});

  @override
  AddBookDialogState createState() => AddBookDialogState();
}

class AddBookDialogState extends State<AddBookDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _coverImageController = TextEditingController();

  bool _onlyTitle = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Book"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text("Only Title"),
                value: _onlyTitle,
                onChanged: (bool? value) {
                  setState(() {
                    _onlyTitle = value ?? true;
                  });
                },
              ),
              if (!_onlyTitle) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _authorController,
                    decoration: const InputDecoration(labelText: "Author"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _yearController,
                    decoration:
                        const InputDecoration(labelText: "Publication Year"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _genreController,
                    decoration: const InputDecoration(labelText: "Genre"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _coverImageController,
                    decoration:
                        const InputDecoration(labelText: "Cover Image URL"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final newBook = BookModel(
                title: _titleController.text,
                author: _onlyTitle ? '' : _authorController.text,
                publicationYear: _onlyTitle ? '' : _yearController.text,
                genre: _onlyTitle
                    ? []
                    : _genreController.text
                        .split(',')
                        .map((e) => e.trim())
                        .toList(),
                description: _onlyTitle ? '' : _descriptionController.text,
                coverImage: _onlyTitle ? '' : _coverImageController.text,
              );
              widget.booksBloc.add(AddBook(newBook));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
