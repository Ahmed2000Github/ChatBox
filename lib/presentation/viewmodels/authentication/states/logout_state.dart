class LogOutState {
  bool isLoading;
  String? errorMessage;
  bool isSuccess;

  LogOutState(
      {this.isLoading = false, this.isSuccess = false, this.errorMessage});
}
