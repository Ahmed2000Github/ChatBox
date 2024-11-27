import 'dart:async';
import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/domain/entities/story/create_story_entity.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, bool>> create(CreateStoryEntity createStoryEntity);
  Future<Either<Failure, List<StoryEntity>>> retrive();
}
