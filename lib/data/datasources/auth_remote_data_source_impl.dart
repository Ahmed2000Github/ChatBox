import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/errors/exceptions.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/models/sign_in_model.dart';
import 'package:chat_box/data/models/sign_up_model.dart';
import 'package:chat_box/data/models/user_infos_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseInstance = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  addUserToDataBase(User user) async {
    final userDto = UserInfosModel(
      id: user.uid,
      email: user.email ?? "",
      name: user.displayName ?? "",
      description: "Hello there I'am using ChatBox",
      profileImage: user.photoURL,
    );

    final usersCollection = firestore.collection(AppConstants.usersCollection);

    try {
      final querySnapshot =
          await usersCollection.where('email', isEqualTo: user.email).get();

      if (querySnapshot.docs.isEmpty) {
        await usersCollection.add(userDto.toJson());
        print("User added to Firestore");
      } else {
        print("User already exists in Firestore");
      }
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }

  @override
  Future<UserCredential> facebookAuthentication() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    try {
      final userCredential =
          await firebaseInstance.signInWithCredential(facebookAuthCredential);
      if (userCredential.user == null) return userCredential;
      await addUserToDataBase(userCredential.user!);
      return userCredential;
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
      final userCredential =
          await firebaseInstance.signInWithCredential(credential);
      if (userCredential.user == null) return userCredential;
      await addUserToDataBase(userCredential.user!);
      return userCredential;
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
        await user.reload();
        await addUserToDataBase(user);
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
    final usersCollection = firestore.collection(AppConstants.usersCollection);
    final docRef = usersCollection.doc(firebaseInstance.currentUser?.uid);
    await docRef.delete();
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
      await user.reload();
      final usersCollection =
          FirebaseFirestore.instance.collection(AppConstants.usersCollection);

      try {
        final docSnapshot =
            await usersCollection.where('email', isEqualTo: user.email).get();

        if (docSnapshot.docs.isNotEmpty) {
          final data = docSnapshot.docs.first.data() as Map<String, dynamic>;
          return UserInfosModel.fromJson(data);
        } else {
          throw NoUserException();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestsException();
        } else {
          throw ServerException();
        }
      } on NoUserException {
        throw NoUserException();
      } catch (e) {
        throw ServerException();
      }
    }
    throw NoUserException();
  }
}
