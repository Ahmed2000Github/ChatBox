import 'package:chat_box/core/errors/exceptions.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/models/sign_in_model.dart';
import 'package:chat_box/data/models/sign_up_model.dart';
import 'package:chat_box/data/models/user_infos_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseInstance = FirebaseAuth.instance;

  @override
  Future<UserCredential> facebookAuthentication() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    try {
      return await firebaseInstance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserCredential> googleAuthentication() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      return await firebaseInstance.signInWithCredential(credential);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserCredential> signIn(SignInModel signIn) async {
    try {
      final userCredential = await firebaseInstance.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );
      if (userCredential.user?.emailVerified ?? false) {
        return userCredential;
      } else {
        throw NoUserException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ExistedAccountException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<UserCredential> signUp(SignUpModel signUp) async {
    try {
      final userCredential =
          await firebaseInstance.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(signUp.name);
        await user.updatePhotoURL(
            "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png");
        await user.reload();
        print("User registered with name: ${signUp.name}");
        print("s user verified : ${user.emailVerified}");
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeekPassException();
      } else if (e.code == 'email-already-in-use') {
        throw ExistedAccountException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<Unit> deleteUser() async {
    await firebaseInstance.currentUser?.reload();
    await firebaseInstance.currentUser?.delete();
    return Future.value(unit);
  }

  @override
  Future<Unit> verifyEmail() async {
    final user = firebaseInstance.currentUser;
    if (user != null) {
      try {
        await user.reload();
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestsException();
        } else {
          throw ServerException();
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw NoUserException();
    }
    return Future.value(unit);
  }

  @override
  Future<UserInfosModel> userInfos() async {
    final user = firebaseInstance.currentUser;
    if (user != null) {
      try {
        await user.reload();
        return UserInfosModel(
            id: user.uid,
            email: user.email ?? "",
            name: user.displayName ?? "",
            description: "Hello there I'am using ChatBox",
            profileImage: user.photoURL);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestsException();
        } else {
          throw ServerException();
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw NoUserException();
    }
  }
}
