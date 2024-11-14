import 'package:chat_box/domain/entities/user_entity.dart';

class UserInfosState {
  bool isLoading;
  UserEntity? user;
  String? errorMessage;

  UserInfosState({this.isLoading = false, this.user, this.errorMessage});
}
