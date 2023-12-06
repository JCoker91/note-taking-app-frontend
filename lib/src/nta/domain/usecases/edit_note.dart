import 'package:equatable/equatable.dart';
import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';

class EditNote extends UseCaseWithParams<void, EditNoteParams> {
  EditNote(this._repository);
  final NoteRepository _repository;

  @override
  ResultFuture<void> call(EditNoteParams params) async => _repository.editNote(
        id: params.id,
        title: params.title,
        content: params.content,
        author: params.author,
      );
}

class EditNoteParams extends Equatable {
  final String id;
  final String title;
  final String content;
  final String author;

  const EditNoteParams(
      {required this.id,
      required this.title,
      required this.content,
      required this.author});

  const EditNoteParams.empty()
      : this(
            id: "1",
            title: '_empty.title',
            content: '_empty.content',
            author: '_empty.author');
  @override
  List<Object?> get props => [id, title, content, author];
}
