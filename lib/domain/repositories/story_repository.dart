import 'dart:async';
import 'package:chat_box/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, bool>> create();
}
