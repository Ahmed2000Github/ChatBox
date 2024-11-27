import 'package:chat_box/data/models/create_story_model.dart';
import 'package:chat_box/data/models/story_model.dart';

abstract class StoryRemoteDataSource {
  Future<bool> create(CreateStoryModel createStoryModel);
  Future<List<StoryModel>> retrive();
}
