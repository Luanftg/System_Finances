import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:system_finances/models/auth_model.dart';
import 'package:system_finances/repositories/auth_repository.dart';

import '../models/user_model.dart';

class AuthRepositoryImp implements AuthRepository {
  FirebaseAuth get _firebase => FirebaseAuth.instance;
  FirebaseFirestore get _firebaseFirestore => FirebaseFirestore.instance;
  @override
  User? get currentUser => _firebase.currentUser;

  @override
  Future<AuthModel> authenticate(AuthModel authModel) async {
    try {
      var signIn = await _firebase.signInWithEmailAndPassword(
          email: authModel.email, password: authModel.password);
      log('user: ${signIn.user!.toString()}');
      return authModel;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AuthModel> register(AuthModel authModel) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final result = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: authModel.email)
          .get();

      if (result.docs.isEmpty) {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: authModel.email, password: authModel.password);
        final userModel = UserModel.fromFBUser(
          userCredential.user?.uid ?? '',
          userCredential.user?.displayName,
          userCredential.user?.photoURL,
          userCredential.user?.email,
        );
        await userCredential.user?.updateDisplayName(authModel.name);
        _firebaseFirestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .set(userModel.toMap());
      }

      return authModel;
    } catch (e) {
      throw Exception(e.toString());
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
