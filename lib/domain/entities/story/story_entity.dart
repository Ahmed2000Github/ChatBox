class StoryEntity {
  String id;
  String name;
  String profileImage;
  String mediaLink;
  String caption;
  DateTime creationDate;
  StoryEntity(
      {required this.id,
      required this.name,
      required this.caption,
      required this.profileImage,
      required this.mediaLink,
      required this.creationDate});
}
