class SignUpState {
  bool isLoading;
  String? errorMessage;
  bool isSuccess;

  SignUpState(
      {this.isLoading = false, this.isSuccess = false, this.errorMessage});
}
