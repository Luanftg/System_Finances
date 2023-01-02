import 'package:flutter/cupertino.dart';
import 'package:system_finances/repositories/home_repository.dart';

import 'package:system_finances/state/user_state.dart';

class UserStore extends ValueNotifier<UserState> {
  final HomeRepository repository;
  UserStore(this.repository) : super(InitialUserState());

  Future<void> fetchUser() async {
    value = LoadindUserState();
    try {
      final user = await repository.getUserLogged();

      if (user != null) {
        value = SucessUserState(user);
      }
    } catch (e) {
      value = ErrorUserState(e.toString());
    }
  }
}
