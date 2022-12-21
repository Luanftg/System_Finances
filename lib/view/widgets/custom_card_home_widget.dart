import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/models/user_model.dart';
import 'package:system_finances/view/components/home/custom_linear_accounts.dart';

class CustomCardHomeWidget extends StatelessWidget {
  final double saldo;
  final String caminhoDaImagem;
  final String nomeDaConta;
  final String tipoDeConta;
  final List<UserModel> users;

  const CustomCardHomeWidget(
      {Key? key,
      required this.saldo,
      required this.caminhoDaImagem,
      required this.nomeDaConta,
      required this.tipoDeConta,
      required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset.zero,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      color: Colors.green,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: Column(
                        children: [
                          const Text('Saldo geral',
                              style: TextStyle(
                                color: Colors.black54,
                                decoration: TextDecoration.none,
                                fontSize: 16,
                              )),
                          Text(
                            'R\$ ${users[0].balance}',
                            style: const TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Text('Minhas Contas',
                  style: Theme.of(context).textTheme.titleMedium),
              CustomLinearAccounts(
                caminhoDaImagem: caminhoDaImagem,
                nomeDaConta: nomeDaConta,
                tipoDeConta: tipoDeConta,
                valor: '$saldo',
              ),
              const Divider(),
              CustomLinearAccounts(
                caminhoDaImagem:
                    users[0].accountList![1].bandeira.caminhoDaImagem,
                nomeDaConta: users[0].accountList![1].bandeira.nome,
                tipoDeConta: tipoDeConta,
                valor: (users[0].accountList![1].bandeira.balance).toString(),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                backgroundColor: AppColors.primary),
            onPressed: () {},
            child: const Text('Gerenciar Contas'),
          ),
        ],
      ),
    );
  }
}
