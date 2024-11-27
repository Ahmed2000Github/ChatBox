import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/story/create_story_entity.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:chat_box/domain/repositories/story_repository.dart';
import 'package:dartz/dartz.dart';

class CreateStoryUsecase {
  StoryRepository storyRepository;
  CreateStoryUsecase(this.storyRepository);
  Future<Either<Failure, bool>> call(
      CreateStoryEntity createStoryEntity) async {
    return storyRepository.create(createStoryEntity);
  }
}
