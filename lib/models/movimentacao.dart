import 'dart:convert';

class Movimentacao {
  String id;
  bool eReceita;
  String diaDeMovimentacao;
  double valor;
  String descricao;
  Movimentacao({
    required this.id,
    required this.eReceita,
    required this.diaDeMovimentacao,
    required this.valor,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'eReceita': eReceita,
      'diaDeMovimentacao': diaDeMovimentacao,
      'valor': valor,
      'descricao': descricao,
    };
  }

  factory Movimentacao.fromMap(Map<String, dynamic> map) {
    final movimentacao = Movimentacao(
      id: map['id'] as String,
      eReceita: map['ehReceita'] as bool,
      diaDeMovimentacao: map['diaDaMovimentacao'] as String,
      valor: map['valor'] as double,
      descricao: map['descricao'] as String,
    );
    return movimentacao;
  }

  String toJson() => json.encode(toMap());

  factory Movimentacao.fromJson(String source) =>
      Movimentacao.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movimentacao(id: $id, eReceita: $eReceita, diaDeMovimentacao: $diaDeMovimentacao, valor: $valor, descricao: $descricao)';
  }
}
