import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:system_finances/models/user_model.dart';
import 'package:system_finances/repositories/home_repository.dart';

class HomeRepositoryImpementation implements HomeRepository {
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  @override
  Future<UserModel?> getUserLogged() async {
    User? userLogged = _firebaseAuth.currentUser;
    if (userLogged != null) {
      UserModel userModelFromFA = UserModel.fromFBUser(userLogged.uid,
          userLogged.displayName, userLogged.photoURL, userLogged.email);
      log(userModelFromFA.toString());
      return userModelFromFA;
    }
    return null;
  }
}
