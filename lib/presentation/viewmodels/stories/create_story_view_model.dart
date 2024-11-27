import 'package:chat_box/domain/entities/story/create_story_entity.dart';
import 'package:chat_box/domain/usecases/stories/create_story_usecase.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/create_story_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class CreateStoryViewModel extends StateNotifier<CreateStoryState> {
  final CreateStoryUsecase createStorysUsecase;

  CreateStoryViewModel(this.createStorysUsecase) : super(CreateStoryState());

  void create(CreateStoryEntity createStoryEntity) async {
    state = CreateStoryState(isLoading: true);
    final result = await createStorysUsecase(createStoryEntity);
    state = result.toStateWithHandlers((result) => CreateStoryState(),
        (failure) => CreateStoryState(errorMessage: failure.getMessage()));
  }

  void resetState() {
    state = CreateStoryState();
  }
}
