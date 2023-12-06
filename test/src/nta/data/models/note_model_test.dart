import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/data/models/note_model.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';

void main() {
  const tModel = NoteModel.empty();
  const tJson =
      '{"id":"1","title":"_empty.title","content":"_empty.content","author":"_empty.author"}';
  final tMap = jsonDecode(tJson) as DataMap;
  test('should be a subclass of [Note] entity', () {
    // arrange
    // act
    //assert
    expect(tModel, isA<Note>());
  });

  group('fromMap', () {
    test('should return a [NoteModel] with the right data.', () {
      // arrange
      // act
      final result = NoteModel.fromMap(tMap);
      // assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [NoteModel] with the right data.', () {
      // arrange
      // act
      final result = NoteModel.fromJson(tJson);
      // assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [DataMap] with the right data.', () {
      // arrange
      // act
      final result = tModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [String] with the right data.', () {
      // arrange
      // act
      final result = tModel.toJson();
      // assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test(
        'should return a [NoteModel] with different title and content but same id and author.',
        () {
      // arrange
      // act
      final result = tModel.copyWith(title: 'newTitle', content: 'newContent');
      // assert
      expect(result.id, equals(tModel.id));
      expect(result.author, equals(tModel.author));
      expect(result.title, equals('newTitle'));
      expect(result.content, equals('newContent'));
    });

    test(
        'should return a [NoteModel] with different title but same id, author, and content.',
        () {
      // arrange
      // act
      final result = tModel.copyWith(
        title: 'newTitle',
      );
      // assert
      expect(result.id, equals(tModel.id));
      expect(result.author, equals(tModel.author));
      expect(result.title, equals('newTitle'));
      expect(result.content, equals(tModel.content));
    });
    test(
        'should return a [NoteModel] with different content but same id, author, and title.',
        () {
      // arrange
      // act
      final result = tModel.copyWith(
        content: 'newContent',
      );
      // assert
      expect(result.id, equals(tModel.id));
      expect(result.author, equals(tModel.author));
      expect(result.title, equals(tModel.title));
      expect(result.content, equals('newContent'));
    });
  });
}
