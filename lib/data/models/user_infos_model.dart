import 'package:chat_box/domain/entities/user_entity.dart';

class UserInfosModel extends UserEntity {
  UserInfosModel({
    required String id,
    required String email,
    required String name,
    required String description,
     String? profileImage,
  }) : super(
          id: id,
          email: email,
          name: name,
          description: description,
          profileImage: profileImage,
        );
}
