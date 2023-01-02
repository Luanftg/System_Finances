import 'package:flutter/material.dart';
import 'package:system_finances/repositories/home_repository.dart';

import '../state/user_state.dart';

class HomeController {
  final HomeRepository _homeRepository;
  HomeController(this._homeRepository);

  ValueNotifier<UserState> user = ValueNotifier<UserState>(InitialUserState());

  fetch() async {
    final userLogged = await _homeRepository.getUserLogged();
    if (userLogged != null) {
      user.value = SucessUserState(userLogged);
    } else {
      user.value = ErrorUserState('Não há usuário Logado!');
    }
  }
}
