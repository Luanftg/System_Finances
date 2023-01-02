import 'dart:convert';

class Bandeira {
  String nome;
  String caminhoDaImagem;
  double balance;
  Bandeira({
    required this.nome,
    required this.caminhoDaImagem,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'imagem': caminhoDaImagem,
      'balance': balance,
    };
  }

  factory Bandeira.fromMap(Map<String, dynamic> map) {
    return Bandeira(
      nome: map['nome'] as String,
      caminhoDaImagem: map['imagem'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bandeira.fromJson(String source) =>
      Bandeira.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Bandeira(nome: $nome, caminhoDaImagem: $caminhoDaImagem, balance: $balance)';
}
