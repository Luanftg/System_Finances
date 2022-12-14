import 'package:firebase_auth/firebase_auth.dart';
import 'package:system_finances/models/auth_model.dart';
import 'package:system_finances/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<AuthModel> authenticate(AuthModel authModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authModel.email, password: authModel.password);
      return authModel;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AuthModel> register(AuthModel authModel) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authModel.email, password: authModel.password);
      return authModel;
    } catch (e) {
      throw Exception();
    }
  }
}
