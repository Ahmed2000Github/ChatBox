import 'package:chat_box/domain/usecases/authentication/logout_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/logout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class LogOutViewModel extends StateNotifier<LogOutState> {
  final LogOutUseCase logOutUseCase;

  LogOutViewModel(this.logOutUseCase) : super(LogOutState());

  void call() async {
    state = LogOutState(isLoading: true);
    final result = await logOutUseCase();
    state = result.toStateWithDefault(LogOutState(isSuccess: true),
        (failure) => LogOutState(errorMessage: failure.getMessage()));
  }

  void resetState() {
    state = LogOutState();
  }
}
