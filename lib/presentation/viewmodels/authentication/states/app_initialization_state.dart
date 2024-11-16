class AppInitializationState {
  bool isLoading;
  String? errorMessage;
  bool? isLoggedIn;

  AppInitializationState(
      {this.isLoading = false, this.isLoggedIn, this.errorMessage});
}
