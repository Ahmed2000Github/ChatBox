import 'package:chat_box/data/models/sign_in_model.dart';
import 'package:chat_box/data/models/sign_up_model.dart';
import 'package:chat_box/data/models/user_infos_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp(SignUpModel signUp);
  Future<UserCredential> signIn(SignInModel signIn);
  Future<UserCredential> googleAuthentication();
  Future<UserCredential> facebookAuthentication();
  Future<UserInfosModel> userInfos();
    Future<Unit> verifyEmail();
}
