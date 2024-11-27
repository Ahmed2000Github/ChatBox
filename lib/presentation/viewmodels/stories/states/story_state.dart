import 'package:chat_box/domain/entities/story/story_entity.dart';
 
class StoryState {
  bool isLoading;
  String? errorMessage;
  List<StoryEntity> stories; 

   StoryState(
      {this.isLoading = false,
      this.stories = const [],
      this.errorMessage});
}
