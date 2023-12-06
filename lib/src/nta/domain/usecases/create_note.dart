import 'package:equatable/equatable.dart';
import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';

class CreateNote extends UseCaseWithParams<void, CreateNoteParams> {
  CreateNote(this._repository);
  final NoteRepository _repository;

  @override
  ResultFuture<void> call(CreateNoteParams params) => _repository.createNote(
      title: params.title, content: params.content, author: params.author);
}

class CreateNoteParams extends Equatable {
  final String title;
  final String content;
  final String author;

  const CreateNoteParams.empty()
      : this(
          title: '_empty.title',
          content: '_empty.content',
          author: '_empty.author',
        );

  const CreateNoteParams(
      {required this.title, required this.content, required this.author});

  @override
  List<Object?> get props => [title, content, author];
}
