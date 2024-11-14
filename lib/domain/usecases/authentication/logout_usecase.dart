import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOutUseCase {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logOut();
  }
}
