import 'dart:convert';

class ValorSimulado {
  final double mounthValue;
  final int mounth;
  final double taxaAA;
  final String userId;
  final double initialValue;
  ValorSimulado({
    required this.initialValue,
    required this.mounthValue,
    required this.mounth,
    required this.taxaAA,
    required this.userId,
  });

  @override
  String toString() {
    return 'ValorSimulado(initialValue: $initialValue, mountValue: $mounthValue, mounth: $mounth, taxaAA: $taxaAA, userId: $userId)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'initialValue': initialValue});
    result.addAll({'mounthValue': mounthValue});
    result.addAll({'mounth': mounth});
    result.addAll({'taxaAA': taxaAA});
    result.addAll({'userId': userId});

    return result;
  }

  factory ValorSimulado.fromMap(Map<String, dynamic> map) {
    return ValorSimulado(
      initialValue: map['initialValue']?.toDouble() ?? 0.0,
      mounthValue: map['mounthValue']?.toDouble() ?? 0.0,
      mounth: map['mounth']?.toInt() ?? 0,
      taxaAA: map['taxaAA']?.toDouble() ?? 0.0,
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ValorSimulado.fromJson(String source) =>
      ValorSimulado.fromMap(json.decode(source));
}
