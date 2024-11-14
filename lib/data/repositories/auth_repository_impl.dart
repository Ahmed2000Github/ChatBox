import 'dart:async';

import 'package:chat_box/core/errors/exceptions.dart';
import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/core/network/network_info.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/models/app_entry_state_model.dart';
import 'package:chat_box/data/models/sign_in_model.dart';
import 'package:chat_box/data/models/sign_up_model.dart';
import 'package:chat_box/domain/entities/app_entry_state_entity.dart';
import 'package:chat_box/domain/entities/sign_in_entity.dart';
import 'package:chat_box/domain/entities/sign_up_entity.dart';
import 'package:chat_box/domain/entities/user_entity.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.networkInfo, required this.authRemoteDataSource});

  @override
  AppEntryStateEntity appEntry() {
    final userCredential = FirebaseAuth.instance.currentUser;
    if (userCredential != null && userCredential.emailVerified) {
      return const AppEntryStateModel(
          isVerifyingEmail: false, isLoggedIn: true);
    } else if (userCredential != null) {
      return const AppEntryStateModel(
          isVerifyingEmail: true, isLoggedIn: false);
    } else {
      return const AppEntryStateModel(
          isVerifyingEmail: false, isLoggedIn: false);
    }
  }
   Future<void> _waitForVerifiedUser(Completer completer) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        completer.complete();
        timer.cancel();
      }
    });
    await completer.future;
  }


  @override
  Future<Either<Failure, Unit>> checkEmailVerification(Completer completer) async {
     try{
     await _waitForVerifiedUser( completer).timeout(const Duration(days: 30));
     return const Right(unit);
   }catch (e){
     return Left(ServerFailure());
   }
  }

  @override
   Future<Either<Failure, UserCredential>> facebookSignIn() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final userCredential = await authRemoteDataSource.facebookAuthentication();
      return Right(userCredential);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final userCredential = await authRemoteDataSource.googleAuthentication();
      return Right(userCredential);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signIn) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());
    try {
      final signInModel =
          SignInModel(email: signIn.email, password: signIn.password);
      final userCredential = await authRemoteDataSource.signIn(signInModel);
      return Right(userCredential);
    } on ExistedAccountException {
      return Left(ExistedAccountFailure());
    } on WrongPasswordException {
      return Left(WrongPasswordFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    if (signUp.password != signUp.repeatedPassword) {
      return Left(UnmatchedPassFailure());
    }
    try {
      final signUpModel = SignUpModel(
          name: signUp.name,
          email: signUp.email,
          password: signUp.password,
          repeatedPassword: signUp.repeatedPassword);
      final userCredential = await authRemoteDataSource.signUp(signUpModel);
      return Right(userCredential);
    } on WeekPassException {
      return Left(WeekPassFailure());
    } on ExistedAccountException {
      return Left(ExistedAccountFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      await authRemoteDataSource.verifyEmail();
      return const Right(unit);
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on NoUserException {
      return Left(NoUserFailure());
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> retriveUserInfos() async {
    try {
      final result = await authRemoteDataSource.userInfos();
      return  Right(result);
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on NoUserException {
      return Left(NoUserFailure());
    }
  }
}
