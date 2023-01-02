import 'dart:convert';

class AuthModel {
  final String email;
  final String password;
  String? name;
  AuthModel(this.email, this.password, {this.name});

  @override
  String toString() =>
      'AuthModel(email: $email, password: $password, name: $name)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      map['email'] ?? '',
      map['password'] ?? '',
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
