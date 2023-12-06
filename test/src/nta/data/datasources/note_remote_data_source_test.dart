import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/errors/exceptions.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/src/nta/data/datasources/note_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late NoteRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = NoteRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('editNote', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note edited successfully', 201);
      const tId = 'Test Id';
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.patch(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // act
      final methodCall = remoteDataSource.editNote;
      // assert
      expect(
          methodCall(
              id: tId, title: tTitle, content: tContent, author: tAuthor),
          completes);
      verify(() => client.patch(Uri.https(kBaseUrl, '$kEditNoteEndpoint/$tId'),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note edition failed', 400);
      const tId = 'Test Id';
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.patch(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // Act
      final methodCall = remoteDataSource.editNote;
      // Assert
      expect(
          () async => methodCall(
              id: tId, title: tTitle, content: tContent, author: tAuthor),
          throwsA(ApiException(
              message: tResponse.body, statusCode: tResponse.statusCode)));
      verify(() => client.patch(Uri.https(kBaseUrl, '$kEditNoteEndpoint/$tId'),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getNotes', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note created successfully', 201);
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // act
      final methodCall = remoteDataSource.createNote;
      // assert
      expect(methodCall(title: tTitle, content: tContent, author: tAuthor),
          completes);
      verify(() => client.post(Uri.https(kBaseUrl, kCreateNoteEndpoint),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note creation failed', 400);
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // Act
      final methodCall = remoteDataSource.createNote;
      // Assert
      expect(
          () async =>
              methodCall(title: tTitle, content: tContent, author: tAuthor),
          throwsA(ApiException(
              message: tResponse.body, statusCode: tResponse.statusCode)));
      verify(() => client.post(Uri.https(kBaseUrl, kCreateNoteEndpoint),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('createNote', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note created successfully', 201);
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // act
      final methodCall = remoteDataSource.createNote;
      // assert
      expect(methodCall(title: tTitle, content: tContent, author: tAuthor),
          completes);
      verify(() => client.post(Uri.https(kBaseUrl, kCreateNoteEndpoint),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      // arrange
      final tResponse = http.Response('Note creation failed', 400);
      const tTitle = 'Test Title';
      const tContent = 'Test Content';
      const tAuthor = 'Test Author';
      when(() => client.post(any(),
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => tResponse);
      // Act
      final methodCall = remoteDataSource.createNote;
      // Assert
      expect(
          () async =>
              methodCall(title: tTitle, content: tContent, author: tAuthor),
          throwsA(ApiException(
              message: tResponse.body, statusCode: tResponse.statusCode)));
      verify(() => client.post(Uri.https(kBaseUrl, kCreateNoteEndpoint),
          body: jsonEncode(
              {'title': tTitle, 'content': tContent, 'author': tAuthor}),
          headers: {'Content-Type': 'application/json'})).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
