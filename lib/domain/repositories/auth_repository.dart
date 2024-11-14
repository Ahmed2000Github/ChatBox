import 'dart:async';

import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/app_entry_state_entity.dart';
import 'package:chat_box/domain/entities/sign_in_entity.dart';
import 'package:chat_box/domain/entities/sign_up_entity.dart';
import 'package:chat_box/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signIn);
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp);
  Future<Either<Failure, UserCredential>> googleSignIn();
  Future<Either<Failure, UserCredential>> facebookSignIn();
  AppEntryStateEntity appEntry();
  Future<Either<Failure, Unit>> verifyEmail();
  Future<Either<Failure, Unit>> checkEmailVerification(Completer completer);
  Future<Either<Failure, UserEntity>> retriveUserInfos();
  Future<Either<Failure, Unit>> logOut();
}
