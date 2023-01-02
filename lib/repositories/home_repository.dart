import 'package:system_finances/models/user_model.dart';

abstract class HomeRepository {
  Future<UserModel?> getUserLogged();
}
