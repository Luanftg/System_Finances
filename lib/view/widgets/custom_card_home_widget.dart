import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/constants/app_text_styles.dart';
import 'package:system_finances/models/user_model.dart';
import 'package:system_finances/view/components/home/custom_linear_accounts.dart';

class CustomCardHomeWidget extends StatelessWidget {
  final UserModel? user;

  const CustomCardHomeWidget({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaDeContasDoUsuario = user?.accountList;
    return Container(
      height: 360,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.white,
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
                      color: AppColors.primary,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saldo geral',
                            style: AppTextStyles.generalGrayBalance,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'R\$ ${user?.balance ?? '0.00'}',
                            style: AppTextStyles.balancelackLabel,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: Icon(
                    Icons.visibility_outlined,
                    color: AppColors.black38,
                  ),
                ),
              ],
            ),
          ),
          const Text('Minhas Contas', style: AppTextStyles.titleslackLabel),
          ListView.builder(
            itemCount: listaDeContasDoUsuario?.length ?? 0,
            itemBuilder: (context, index) {
              return CustomLinearAccounts(
                caminhoDaImagem:
                    listaDeContasDoUsuario?[index].bandeira.caminhoDaImagem,
                nomeDaConta: listaDeContasDoUsuario?[index].bandeira.nome,
                tipoDeConta: listaDeContasDoUsuario?[index].tipoDeConta,
                valor: '${listaDeContasDoUsuario?[index].bandeira.balance}',
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
