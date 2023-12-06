import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/exceptions.dart';
import 'package:frontend/core/errors/failure.dart';
import 'package:frontend/core/utils/typedef.dart';
import 'package:frontend/src/nta/data/datasources/note_remote_data_source.dart';
import 'package:frontend/src/nta/domain/entities/note.dart';
import 'package:frontend/src/nta/domain/repositories/note_repository.dart';

class NoteRepositoryImplementation implements NoteRepository {
  const NoteRepositoryImplementation(this._remoteDataSource);

  final NoteRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createNote(
      {required String title,
      required String content,
      required String author}) async {
    try {
      await _remoteDataSource.createNote(
          title: title, content: content, author: author);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
    return const Right(null);
  }

  @override
  ResultVoid editNote(
      {required String id,
      required String title,
      required String content,
      required String author}) async {
    try {
      await _remoteDataSource.editNote(
          id: id, title: title, content: content, author: author);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
    return const Right(null);
  }

  @override
  ResultFuture<List<Note>> getNotes() async {
    try {
      final users = await _remoteDataSource.getNotes();
      return Right(users);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
