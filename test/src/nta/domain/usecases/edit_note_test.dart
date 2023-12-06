import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';
import 'package:frontend/src/nta/domain/usecases/edit_note.dart';
import 'package:mocktail/mocktail.dart';

import 'note_repository.mock.dart';

void main() {
  late EditNote useCase;
  late NoteRepository repository;

  setUp(() {
    repository = MockNoteRepository();
    useCase = EditNote(repository);
  });
  const params = EditNoteParams.empty();
  test(
      'should call the [NoteRepository.EditNote] method and return void on success',
      () async {
    // arrange
    when(() => repository.editNote(
            id: any(named: 'id'),
            title: any(named: 'title'),
            content: any(named: 'content'),
            author: any(named: 'author')))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await useCase(params);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.editNote(
        id: params.id,
        title: params.title,
        content: params.content,
        author: params.author)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
