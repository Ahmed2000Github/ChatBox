import 'package:chat_box/domain/entities/story/story_entity.dart';

class StoryModel extends StoryEntity {
  StoryModel(
      {required id,
      required name,
      required profileImage,
      required fileUrl,
      required creationDate})
      : super(
            id: id,
            name: name,
            profileImage: profileImage,
            mediaLink: fileUrl,
            creationDate: creationDate);
}
