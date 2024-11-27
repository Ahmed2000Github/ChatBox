import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/authentication/sign_up_entity.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase(this.repository);

  Future<Either<Failure, UserCredential>> call(
      SignUpEntity signUpEntity) async {
    return await repository.signUp(signUpEntity);
  }
}