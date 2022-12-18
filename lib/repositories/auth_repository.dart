import '../models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> register(AuthModel authModel);
  Future<AuthModel> authenticate(AuthModel authModel);
  bool isAuthenticated();
  Future<void> logout();
}
