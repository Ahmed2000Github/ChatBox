class EmailVerificationState {
  bool isLoading;
  String? errorMessage;
  bool? isSuccess;

  EmailVerificationState(
      {this.isLoading = false, this.isSuccess, this.errorMessage});
}
