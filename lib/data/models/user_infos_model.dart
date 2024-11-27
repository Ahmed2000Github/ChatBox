import 'package:chat_box/domain/entities/authentication/user_entity.dart';

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
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'description': description,
        'profileImage': profileImage,
      };

  factory UserInfosModel.fromJson(Map<String, dynamic> json) => UserInfosModel(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        description: json['description'],
        profileImage: json['profileImage'],
      );
}
