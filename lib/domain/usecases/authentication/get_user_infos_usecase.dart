import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/authentication/user_entity.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserInfosUsecase {
 final AuthRepository repository;

  GetUserInfosUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.retriveUserInfos();
  }
}