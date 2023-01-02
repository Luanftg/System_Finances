import 'package:system_finances/models/user_model.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class SucessUserState extends UserState {
  final UserModel user;
  SucessUserState(this.user);
}

class LoadindUserState extends UserState {}

class ErrorUserState extends UserState {
  final String message;
  ErrorUserState(this.message);
}
