import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/models/user_model.dart';
import 'package:system_finances/repositories/auth_repository.dart';
import 'package:system_finances/repositories/auth_repository_imp.dart';

import 'package:system_finances/view/components/home/custom_linear_home_contact.dart';

class CustomMenuContainerWidget extends StatelessWidget {
  CustomMenuContainerWidget({super.key, this.user});

  final AuthRepository _authRepository = AuthRepositoryImp();
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      color: AppColors.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLinearContactWidget(
            contactName: user?.name ?? user?.email,
            pathContactImage: user?.image,
          ),
          const SizedBox(width: 16),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: AppColors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset.zero,
                  )
                ],
              )),
          IconButton(
            onPressed: () {
              _authRepository.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (_) => false);
            },
            icon: const Icon(Icons.logout),
            alignment: Alignment.topRight,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
