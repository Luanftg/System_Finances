class AuthModel {
  final String email;
  final String password;
  AuthModel(this.email, this.password);

  @override
  String toString() => 'AuthModel(email: $email, password: $password)';
}
