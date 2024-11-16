import 'dart:async';
import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendEmailUseCase {
  final AuthRepository repository;

  SendEmailUseCase(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.verifyEmail();
  }
}
