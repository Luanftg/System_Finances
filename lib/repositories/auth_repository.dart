import '../models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> authenticate(AuthModel authModel);
  Future<AuthModel> register(AuthModel authModel);
}
