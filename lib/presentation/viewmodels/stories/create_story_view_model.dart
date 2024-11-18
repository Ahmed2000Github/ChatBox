import 'package:chat_box/domain/usecases/stories/create_story_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class CreateStoryViewModel extends StateNotifier<UserInfosState> {
  final CreateStoryUsecase createStorysUsecase;

  CreateStoryViewModel(this.createStorysUsecase) : super(UserInfosState());

  void load() async {
    state = UserInfosState(isLoading: true);
    final result = await createStorysUsecase();
    state = result.toStateWithHandlers((result) => UserInfosState(user: result),
        (failure) => UserInfosState(errorMessage: failure.getMessage()));
  }
}
