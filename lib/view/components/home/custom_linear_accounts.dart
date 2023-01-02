// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_text_styles.dart';
import 'package:system_finances/view/components/home/custom_circular_contact_image.dart';

class CustomLinearAccounts extends StatelessWidget {
  final String? valor;
  final String? caminhoDaImagem;
  final String? nomeDaConta;
  final String? tipoDeConta;

  const CustomLinearAccounts({
    Key? key,
    this.valor,
    this.caminhoDaImagem,
    this.nomeDaConta,
    this.tipoDeConta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCircularContactImage(
              pathContactImage: caminhoDaImagem,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nomeDaConta ?? 'nomedaConta',
                  style: AppTextStyles.blackLabel,
                ),
                Text(
                  tipoDeConta ?? 'tipoDeConta',
                  style: AppTextStyles.label,
                ),
              ],
            ),
          ],
        ),
        Text('R\$ $valor?? 0.00')
      ],
    );
  }
}
