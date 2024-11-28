class CreateStoryState {
  bool isLoading;
  String? errorMessage;
  bool? isSuccess;

  CreateStoryState(
      {this.isLoading = false,
      this.isSuccess ,
      this.errorMessage});
}