import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_text_styles.dart';

import 'custom_circular_contact_image.dart';

class CustomLinearContactWidget extends StatelessWidget {
  final String? pathContactImage;
  final String? contactName;
  const CustomLinearContactWidget(
      {Key? key, this.pathContactImage, this.contactName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CustomCircularContactImage(),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Olá !',
                  style: AppTextStyles.whiteLabel,
                ),
                Text(
                  contactName ?? "Bem Vindo ao App",
                  style: AppTextStyles.whiteLabel,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
