import 'package:chat_box/domain/usecases/authentication/get_user_infos_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class UserInfosViewModel extends StateNotifier<UserInfosState> {
  final GetUserInfosUsecase getUserInfosUsecase;

  UserInfosViewModel(this.getUserInfosUsecase) : super(UserInfosState());

  void load() async {
    state = UserInfosState(isLoading: true);
    final result = await getUserInfosUsecase();
    state = result.toStateWithHandlers((result) => UserInfosState(user: result),
        (failure) => UserInfosState(errorMessage: failure.getMessage()));
  }
}
