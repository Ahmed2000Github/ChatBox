
import 'dart:async';

import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailVerificationUseCase {
  final AuthRepository repository;

  EmailVerificationUseCase(this.repository);

   Future<Either<Failure, bool>> call(){
    return  repository.checkEmailVerification();
  }
}
