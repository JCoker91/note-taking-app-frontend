import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';

class GetNotes extends UseCaseWithoutParams<List<Note>> {
  const GetNotes(this._repository);
  final NoteRepository _repository;

  @override
  ResultFuture<List<Note>> call() async => _repository.getNotes();
}
