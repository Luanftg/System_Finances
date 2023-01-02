import 'dart:convert';

import 'bandeira.dart';
import 'movimentacao.dart';

class Contas {
  Bandeira bandeira;
  List<Movimentacao> listaDeMovimentacao;
  final String? tipoDeConta;
  Contas(
    this.tipoDeConta, {
    required this.bandeira,
    required this.listaDeMovimentacao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipoDeConta': tipoDeConta ?? '',
      'bandeira': bandeira.toMap(),
      'listaDeMovimentacao': listaDeMovimentacao.map((x) => x.toMap()).toList(),
    };
  }

  factory Contas.fromMap(Map<String, dynamic> map) {
    return Contas(
      map['tipoDeConta'] ?? '',
      bandeira: Bandeira.fromMap(map['bandeira'] as Map<String, dynamic>),
      listaDeMovimentacao: List<Movimentacao>.from(
        (map['listaDeMovimentacao'] as List).map<Movimentacao>(
          (x) => Movimentacao.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contas.fromJson(String source) =>
      Contas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Contas(tipoDeConta: $tipoDeConta, $bandeira, listaDeMovimentacao: $listaDeMovimentacao)';
}
