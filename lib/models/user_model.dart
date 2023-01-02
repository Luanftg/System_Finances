import 'dart:convert';

import 'contas.dart';

class UserModel {
  final String userId;
  final String? name;
  final String? email;
  final String? image;
  final double? balance;
  final List<Contas>? accountList;
  UserModel({
    required this.userId,
    required this.name,
    required this.image,
    this.accountList,
    this.balance,
    this.email,
  });

  factory UserModel.fromFBUser(
      String id, String? name, String? photoUrl, String? email) {
    return UserModel(userId: id, name: name, image: photoUrl, email: email);
  }

  factory UserModel.fromJson(Map json) {
    return UserModel(
      balance: json['balance'] ?? 0,
      userId: json['userId'],
      name: json['name'],
      image: json['image'],
      accountList: List<Contas>.from(
        json['listaDeConta'].map(
              (e) => Contas.fromMap(e),
            ) ??
            [],
      ),
    );
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, image: $image, balance: $balance, accountList: $accountList, email: $email)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (balance != null) {
      result.addAll({'balance': balance});
    }
    if (accountList != null) {
      result
          .addAll({'accountList': accountList!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'],
      email: map['email'],
      image: map['image'],
      balance: map['balance']?.toDouble(),
      accountList: map['accountList'] != null
          ? List<Contas>.from(map['accountList']?.map((x) => Contas.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
}
