import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirmed;

  const DeleteConfirmationDialog({required this.onConfirmed, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this book?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Return false
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirmed();
            Navigator.of(context).pop(); // Return true
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
