import 'package:system_finances/models/auth_model.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class SucessAuthState extends AuthState {
  final AuthModel authModel;
  SucessAuthState(this.authModel);
}

class LoadindAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState(this.message);
}
