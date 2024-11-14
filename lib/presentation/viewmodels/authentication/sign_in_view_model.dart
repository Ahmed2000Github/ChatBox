import 'package:chat_box/domain/usecases/authentication/facebook_auth_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/google_auth_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class SignInViewModel extends StateNotifier<SignInState> {
  final GoogleAuthUseCase googleAuthUseCase;
  final FacebookAuthUsecase facebookAuthUsecase;

  bool _isLocked = false;

  SignInViewModel(this.googleAuthUseCase,this.facebookAuthUsecase) : super(SignInState());

  void googleSignIn() async {
    if (_isLocked) return;
    _isLocked = true;
    state = GoogleSignInState(isLoading: true);
    final result = await googleAuthUseCase();

    state = result.toStateWithDefault(GoogleSignInState(isSuccess: true),
        (failure) => GoogleSignInState(errorMessage: failure.getMessage()));
    _isLocked = false;
  }

  void facebookSignIn() async {
    if (_isLocked) return;
    _isLocked = true;
    state = FacebookSignInState(isLoading: true);
    final result = await facebookAuthUsecase();
    
    state = result.toStateWithDefault(FacebookSignInState(isSuccess: true),
        (failure) => SignInState(errorMessage: failure.getMessage()));
    _isLocked = false;
  }
  void resetState() {
    state = SignInState();
  }
}
