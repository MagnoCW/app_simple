import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final bool isFavorite;

  const Post({
    required this.id,
    required this.title,
    required this.body,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, title, body, isFavorite];

  Post copyWith({
    int? id,
    String? title,
    String? body,
    bool? isFavorite,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
