class StoryEntity {
  String id;
  String name;
  String profileImage;
  String mediaLink;
  DateTime creationDate;
  StoryEntity(
      {required this.id,
      required this.name,
      required this.profileImage,
      required this.mediaLink,
      required this.creationDate});
}
