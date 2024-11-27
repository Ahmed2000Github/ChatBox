import 'package:chat_box/core/errors/failures.dart';
import 'package:chat_box/core/network/network_info.dart';
import 'package:chat_box/data/datasources/interfaces/story_remote_data_source.dart';
import 'package:chat_box/data/models/create_story_model.dart';
import 'package:chat_box/domain/entities/story/create_story_entity.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:chat_box/domain/repositories/story_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSource storyRemoteDataSource;
  final NetworkInfo networkInfo;

  StoryRepositoryImpl(
      {required this.networkInfo, required this.storyRemoteDataSource});
  @override
  Future<Either<Failure, bool>> create(
      CreateStoryEntity createStoryEntity) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left(NoUserFailure());
    final createStoryModel = CreateStoryModel(
        creationDate: DateTime.now(),
        fileUrl: createStoryEntity.tempPath, 
        userId: user.email ?? "",
        caption: createStoryEntity.caption);
    await storyRemoteDataSource.create(createStoryModel);
    return Right(true);
  }

  @override
  Future<Either<Failure, List<StoryEntity>>> retrive() async {
    final result  = await storyRemoteDataSource.retrive();
    final stories = result.map((model)=>model as StoryEntity).toList();
    return Right(stories);
  }
}
