import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:system_finances/models/auth_model.dart';
import 'package:system_finances/repositories/auth_repository.dart';
import 'package:system_finances/state/auth_state.dart';

class AuthStore extends ValueNotifier<AuthState> {
  final AuthRepository _authRepository;
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);
  String? login;
  String? pass;

  AuthStore(this._authRepository) : super(InitialAuthState());

  setLogin(String value) => login = value;

  setPass(String value) => pass = value;

  Future authenticate(AuthModel authModel) async {
    value = LoadindAuthState();
    inLoader.value = true;
    try {
      log(authModel.toString());
      final authUser = await _authRepository.authenticate(authModel);
      await Future.delayed(const Duration(seconds: 2));
      value = SucessAuthState(authUser);
      inLoader.value = false;
    } catch (e) {
      value = ErrorAuthState(e.toString());
    }
  }

  Future register(AuthModel authModel) async {
    inLoader.value = true;
    value = LoadindAuthState();
    try {
      final authUser = await _authRepository.register(authModel);
      inLoader.value = false;
      value = SucessAuthState(authUser);
    } catch (e) {
      value = ErrorAuthState(e.toString());
      inLoader.value = false;
    }
  }
}
