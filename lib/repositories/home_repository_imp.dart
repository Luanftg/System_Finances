import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:system_finances/models/user_model.dart';

import 'home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<List<UserModel>> getList() async {
    try {
      // var response = await Dio().get('http://34.23.32.231:8080/accounts');
      var response = await Dio()
          .get('https://luanftg.github.io/teste-git/finances_api.json');
      final users =
          (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      return users;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
