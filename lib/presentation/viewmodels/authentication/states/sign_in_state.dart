class SignInState {
  bool isLoading;
  String? errorMessage;
  bool isSuccess;

  SignInState(
      {this.isLoading = false, this.isSuccess = false, this.errorMessage});
}

class GoogleSignInState extends SignInState {
  GoogleSignInState({isLoading = false, isSuccess = false, errorMessage})
      : super(
            isLoading: isLoading,
            isSuccess: isSuccess,
            errorMessage: errorMessage);
}

class FacebookSignInState extends SignInState {
  FacebookSignInState({isLoading = false, isSuccess = false, errorMessage})
      : super(
            isLoading: isLoading,
            isSuccess: isSuccess,
            errorMessage: errorMessage);
}

class EmailAndPasswordSignInState extends SignInState {
  EmailAndPasswordSignInState(
      {isLoading = false, isSuccess = false, errorMessage})
      : super(
            isLoading: isLoading,
            isSuccess: isSuccess,
            errorMessage: errorMessage);
}
