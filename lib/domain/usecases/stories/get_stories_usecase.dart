import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:chat_box/domain/repositories/story_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoriesUsecase {
 StoryRepository storyRepository;
  GetStoriesUsecase(this.storyRepository);
  Future<Either<Failure, List<StoryEntity>>> call() async {
    return storyRepository.retrive();
  }
}