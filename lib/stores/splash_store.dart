import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../state/splash_state.dart';

class SplashStore extends ValueNotifier<SplashState> {
  SplashStore() : super(LoadingSplashState());

  FirebaseAuth get _firebase => FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    if (_firebase.currentUser != null) {
      value = UserAuthenticatedSplashState();
      return true;
    }
    value = UserUnauthenticatedSplashState();
    return false;
  }
}
