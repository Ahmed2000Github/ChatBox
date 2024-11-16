import 'package:chat_box/domain/usecases/authentication/app_initialization_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/app_initialization_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class AppInitializationViewModel extends StateNotifier<AppInitializationState> {
  final AppInitializationUsecase appInitializationUsecase;

  AppInitializationViewModel(this.appInitializationUsecase)
      : super(AppInitializationState());

  void init() async {
    state = AppInitializationState(isLoading: true);

    final result = await appInitializationUsecase();

    state = result.toStateWithHandlers(
        (result) => AppInitializationState(isLoggedIn: result),
        (failure) =>
            AppInitializationState(errorMessage: failure.getMessage()));
  }

  void resetState() {
    state = AppInitializationState();
  }
}
