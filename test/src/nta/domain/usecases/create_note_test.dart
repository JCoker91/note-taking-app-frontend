import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';
import 'package:frontend/src/nta/domain/usecases/create_note.dart';
import 'package:mocktail/mocktail.dart';

import 'note_repository.mock.dart';

void main() {
  late CreateNote useCase;
  late NoteRepository repository;

  setUp(() {
    repository = MockNoteRepository();
    useCase = CreateNote(repository);
  });

  const params = CreateNoteParams.empty();
  test('should call the [NoteRepository.CreateNote] method and return void',
      () async {
    // arrange
    when(() => repository.createNote(
          title: any(named: 'title'),
          content: any(named: 'content'),
          author: any(named: 'author'),
        )).thenAnswer((_) async => const Right(null));
    // act
    final result = await useCase(params);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createNote(
          title: params.title,
          content: params.content,
          author: params.author,
        )).called(1);
    verifyNoMoreInteractions(repository);
  });
}
