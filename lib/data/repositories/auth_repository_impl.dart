import 'dart:async';

import 'package:chat_box/core/errors/exceptions.dart';
import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/core/network/network_info.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/models/sign_in_model.dart';
import 'package:chat_box/data/models/sign_up_model.dart';
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
  Future<Either<Failure, bool>> appEntry() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());
    try {
      final userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null && userCredential.emailVerified) {
        return const Right(true);
      } else if (userCredential != null) {
        await authRemoteDataSource.deleteUser();
      }
      return const Right(false);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<bool> _waitForVerifiedUser() async {
    final Completer<bool> completer = Completer<bool>();
    const Duration checkInterval = Duration(seconds: 1);
    const Duration timeoutDuration = Duration(minutes: 30);

    Timer? mainTimer;

    mainTimer = Timer.periodic(checkInterval, (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        completer.complete(true);
        print("Email verified!");
        timer.cancel();
      }
    });

    Timer(timeoutDuration, () async {
      if (mainTimer?.isActive ?? false) {
        print("Timer canceled after 30 minutes.");
        mainTimer?.cancel();
        await authRemoteDataSource.deleteUser();
        completer.complete(false);
      }
    });
    return await completer.future;
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification() async {
    try {
      final result = await _waitForVerifiedUser();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> facebookSignIn() async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final userCredential =
          await authRemoteDataSource.facebookAuthentication();
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
    } on NoUserException {
      return Left(NoUserFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final signUpModel = SignUpModel(
          name: signUp.name, email: signUp.email, password: signUp.password);
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
      return Right(result);
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on NoUserException {
      return Left(NoUserFailure());
    }
  }
}
