import 'package:chat_box/domain/usecases/stories/get_stories_usecase.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/story_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class StoryViewModel extends StateNotifier<StoryState> {
  final GetStoriesUsecase getStoriesUsecase;

  StoryViewModel(this.getStoriesUsecase) : super(StoryState());

  void load() async {
    state = StoryState(isLoading: true);
    final result = await getStoriesUsecase();
    state = result.toStateWithHandlers((result) => StoryState(stories: result),
        (failure) => StoryState(errorMessage: failure.getMessage()));
  }
}
