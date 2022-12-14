import 'dart:developer';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerService {
  static Future<bool> haveConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      log('Dispositivo Conectado À Internet!');
      return true;
    } else {
      log('Sem internet :( Motivo: ');
      log(InternetConnectionChecker().toString());
      return false;
    }
  }
}
