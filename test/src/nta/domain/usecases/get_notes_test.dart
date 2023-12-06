import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';
import 'package:frontend/src/nta/domain/usecases/get_notes.dart';
import 'package:mocktail/mocktail.dart';

import 'note_repository.mock.dart';

void main() {
  late GetNotes useCase;
  late NoteRepository repository;

  setUp(() {
    repository = MockNoteRepository();
    useCase = GetNotes(repository);
  });

  const testResponse = [Note.empty()];

  test(
      'should call the [NoteRespository.getNotes] method and return [List<Note>].',
      () async {
    // arrange
    when(() => repository.getNotes()).thenAnswer(
      (_) async => const Right(testResponse),
    );
    // act
    final result = await useCase();
    // assert
    expect(result, equals(const Right<dynamic, List<Note>>(testResponse)));
    verify(() => repository.getNotes()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
