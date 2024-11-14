class SignUpEntity {
  final String name;
  final String email;
  final String password;
  final String repeatedPassword;

  const SignUpEntity(
      {required this.name,
      required this.email,
      required this.password,
      required this.repeatedPassword});
}
