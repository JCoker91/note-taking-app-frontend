import 'dart:convert';

import 'package:frontend/core/errors/exceptions.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/src/nta/data/models/note_model.dart';
import 'package:http/http.dart' as http;

abstract class NoteRemoteDataSource {
  Future<void> createNote({
    required String title,
    required String content,
    required String author,
  });

  Future<void> editNote({
    required String id,
    required String title,
    required String content,
    required String author,
  });

  Future<List<NoteModel>> getNotes();
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  const NoteRemoteDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<void> createNote(
      {required String title,
      required String content,
      required String author}) async {
    try {
      final response = await _client.post(
          Uri.https(kBaseUrl, kCreateNoteEndpoint),
          body: jsonEncode(
              {'title': title, 'content': content, 'author': author}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetNotesEndpoint),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return jsonDecode(response.body)
          .map<NoteModel>((note) => NoteModel.fromJson(note))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> editNote(
      {required String id,
      required String title,
      required String content,
      required String author}) async {
    try {
      final response = await _client.patch(
          Uri.https(kBaseUrl, '$kCreateNoteEndpoint/$id'),
          body: jsonEncode(
              {'title': title, 'content': content, 'author': author}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
