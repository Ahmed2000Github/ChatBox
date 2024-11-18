import 'package:chat_box/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class CreateStoryUsecase {


Future<Either<Failure,bool>> call()async{
  return const Right(true);
}
}