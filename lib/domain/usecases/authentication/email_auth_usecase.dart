import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/sign_in_entity.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthUsecase {
  final AuthRepository repository;

  EmailAuthUsecase(this.repository);

  Future<Either<Failure, UserCredential>> call(
      SignInEntity signInEntity) async {
    return await repository.signIn(signInEntity);
  }
}
