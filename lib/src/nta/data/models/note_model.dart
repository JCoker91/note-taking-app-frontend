import 'dart:convert';

import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.author});

  const NoteModel.empty() : super.empty();

  NoteModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          title: map['title'] as String,
          content: map['content'] as String,
          author: map['author'] as String,
        );
  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(jsonDecode(source) as DataMap);

  NoteModel copyWith({
    String? title,
    String? content,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
      };

  String toJson() => jsonEncode(toMap());
}
