import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';

class CustomCircularContactImage extends StatelessWidget {
  final String? pathContactImage;
  const CustomCircularContactImage({
    Key? key,
    this.pathContactImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        image: DecorationImage(
          image: NetworkImage(pathContactImage ??
              'https://static.vecteezy.com/system/resources/previews/002/318/271/original/user-profile-icon-free-vector.jpg'),
        ),
      ),
    );
  }
}
