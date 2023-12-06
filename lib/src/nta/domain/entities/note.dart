import 'package:equatable/equatable.dart';

class Note extends Equatable {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
  });
  final String id;
  final String title;
  final String content;
  final String author;

  const Note.empty()
      : this(
          id: "1",
          title: '_empty.title',
          content: '_empty.content',
          author: '_empty.author',
        );

  @override
  List<Object?> get props => [id, title, content, author];
}
