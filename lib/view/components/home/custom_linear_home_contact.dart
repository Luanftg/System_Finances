import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';

import 'custom_circular_contact_image.dart';

class CustomLinearContactWidget extends StatelessWidget {
  final String pathContactImage;
  final String contactName;
  const CustomLinearContactWidget(
      {Key? key, required this.pathContactImage, required this.contactName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomCircularContactImage(
              pathContactImage: pathContactImage,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Olá !',
                  style: TextStyle(color: AppColors.white70),
                ),
                Text(
                  contactName,
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
