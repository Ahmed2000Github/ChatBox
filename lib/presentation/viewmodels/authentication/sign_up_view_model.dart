import 'package:chat_box/domain/entities/authentication/sign_up_entity.dart';
import 'package:chat_box/domain/usecases/authentication/sign_up_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_up_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpUsecase signUpUsecase;

  SignUpViewModel(this.signUpUsecase) : super(SignUpState());

  void signUp(SignUpEntity signUpEntity) async {
    state = SignUpState(isLoading: true);
    final result = await signUpUsecase(signUpEntity);

    state = result.toStateWithDefault(SignUpState(isSuccess: true),
        (failure) => SignUpState(errorMessage: failure.getMessage()));
  }

  void resetState() {
    state = SignUpState();
  }
}
