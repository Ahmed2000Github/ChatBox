import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AppInitializationUsecase {
  final AuthRepository repository;

  AppInitializationUsecase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.appEntry();
  }
}
