import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthUseCase {
  final AuthRepository repository;

  GoogleAuthUseCase(this.repository);

  Future<Either<Failure, UserCredential>> call() async {
    return await repository.googleSignIn();
  }
}
