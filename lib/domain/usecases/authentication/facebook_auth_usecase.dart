import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookAuthUsecase {
  final AuthRepository repository;

  FacebookAuthUsecase(this.repository);

  Future<Either<Failure, UserCredential>> call() async {
    return await repository.facebookSignIn();
  }
}
