class UserEntity {
  String id;
  String email;
  String name;
  String description;
  String? profileImage;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.description,
     this.profileImage,
  });
}
