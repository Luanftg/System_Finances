import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:system_finances/models/auth_model.dart';
import 'package:system_finances/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  FirebaseAuth get _firebase => FirebaseAuth.instance;

  @override
  Future<AuthModel> authenticate(AuthModel authModel) async {
    try {
      var signIn = await _firebase.signInWithEmailAndPassword(
          email: authModel.email, password: authModel.password);
      log(signIn.toString());
      return authModel;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AuthModel> register(AuthModel authModel) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _firebase.createUserWithEmailAndPassword(
          email: authModel.email, password: authModel.password);
      return authModel;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  bool isAuthenticated() {
    if (_firebase.currentUser != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await _firebase.signOut();
  }
}
