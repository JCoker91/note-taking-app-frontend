import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/errors/exceptions.dart';
import 'package:frontend/core/errors/failure.dart';
import 'package:frontend/src/nta/data/datasources/note_remote_data_source.dart';
import 'package:frontend/src/nta/data/repositories/note_repository_implementation.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements NoteRemoteDataSource {}

void main() {
  late NoteRemoteDataSource dataSource;
  late NoteRepositoryImplementation repoImpl;

  setUp(() {
    dataSource = MockRemoteDataSource();
    repoImpl = NoteRepositoryImplementation(dataSource);
  });

  const tException =
      ApiException(message: 'Unknown Error Occured', statusCode: 500);

  group('createNote', () {
    const tTitle = 'Test Title';
    const tContent = 'Test Content';
    const tAuthor = 'Test Author';

    test(
        'should call the [RemoteDataSource.createNote] and complete successful when the call to the remote source is successful',
        () async {
      // arrange
      when(() => dataSource.createNote(
            title: any(named: 'title'),
            content: any(named: 'content'),
            author: any(named: 'author'),
          )).thenAnswer((_) async => Future.value());
      // act
      final result = await repoImpl.createNote(
          title: tTitle, content: tContent, author: tAuthor);
      // assert
      expect(result, equals(const Right(null)));
      verify(() => dataSource.createNote(
          title: tTitle, content: tContent, author: tAuthor)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
      // arrange
      when(() => dataSource.createNote(
          title: any(named: 'title'),
          content: any(named: 'content'),
          author: any(named: 'author'))).thenThrow(tException);
      // act
      final result = await repoImpl.createNote(
          title: tTitle, content: tContent, author: tAuthor);
      // assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );
      verify(() => dataSource.createNote(
          title: tTitle, content: tContent, author: tAuthor)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('editNote', () {
    const tId = '1';
    const tTitle = 'Test Title';
    const tContent = 'Test Content';
    const tAuthor = 'Test Author';

    test(
        'should call the [RemoteDataSource.editNote] and complete successful when the call to the remote source is successful',
        () async {
      // arrange
      when(() => dataSource.editNote(
            id: any(named: 'id'),
            title: any(named: 'title'),
            content: any(named: 'content'),
            author: any(named: 'author'),
          )).thenAnswer((_) async => Future.value());
      // act
      final result = await repoImpl.editNote(
        id: tId,
        title: tTitle,
        content: tContent,
        author: tAuthor,
      );
      // assert
      expect(result, equals(const Right(null)));
      verify(() => dataSource.editNote(
            id: tId,
            title: tTitle,
            content: tContent,
            author: tAuthor,
          )).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
      // arrange
      when(() => dataSource.editNote(
            id: any(named: 'id'),
            title: any(named: 'title'),
            content: any(named: 'content'),
            author: any(named: 'author'),
          )).thenThrow(tException);
      // act
      final result = await repoImpl.editNote(
        id: tId,
        title: tTitle,
        content: tContent,
        author: tAuthor,
      );
      // assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );
      verify(() => dataSource.editNote(
          id: tId,
          title: tTitle,
          content: tContent,
          author: tAuthor)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('getNotes', () {
    test(
        'should call [RemoteDataSource.getNotes] and return [List<Note>] when call to remote source is successful',
        () async {
      // arrange
      when(() => dataSource.getNotes()).thenAnswer((_) async => []);
      // act
      final result = await repoImpl.getNotes();
      // assert
      expect(result, isA<Right<dynamic, List<Note>>>());
      verify(() => dataSource.getNotes()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should call the [RemoteDataSource.getNotes] and return [ApiFailure] when call to remote source is unsuccessful',
        () async {
      // arrange
      when(() => dataSource.getNotes()).thenThrow(tException);
      // act
      final result = await repoImpl.getNotes();
      // assert
      expect(
          result,
          equals(
              Left<ApiFailure, dynamic>(ApiFailure.fromException(tException))));
      verify(() => dataSource.getNotes()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
