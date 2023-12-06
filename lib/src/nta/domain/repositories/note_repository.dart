import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';

abstract class NoteRepository {
  const NoteRepository();

  ResultFuture<List<Note>> getNotes();

  ResultVoid editNote({
    required String id,
    required String title,
    required String content,
    required String author,
  });

  ResultVoid createNote({
    required String title,
    required String content,
    required String author,
  });
}
