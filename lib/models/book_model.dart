import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String publicationYear;

  @HiveField(4)
  final List<String> genre;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String coverImage;

  const BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.genre,
    required this.description,
    required this.coverImage,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'].toString(),
      title: json['title'],
      author: json['author'],
      publicationYear: json['publication_year'].toString(),
      genre: List<String>.from(json['genre']),
      description: json['description'],
      coverImage: json['cover_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publication_year': publicationYear,
      'genre': genre,
      'description': description,
      'cover_image': coverImage,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        publicationYear,
        genre,
        description,
        coverImage,
      ];
}
