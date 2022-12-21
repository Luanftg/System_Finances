import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/state/auth_state.dart';
import 'package:system_finances/stores/auth_store.dart';

import '../../../models/auth_model.dart';

class CustomLoginButtonComponent extends StatelessWidget {
  //final LoginController loginControler;
  final AuthStore authStore;

  const CustomLoginButtonComponent({
    Key? key,
    required this.authStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navContext = Navigator.of(context);
    var scaffoldContext = ScaffoldMessenger.of(context);
    AuthModel? authModel;
    return ValueListenableBuilder<bool>(
        valueListenable: authStore.inLoader,
        builder: (_, inLoader, __) => inLoader
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      authModel = AuthModel(authStore.login!, authStore.pass!);
                      await authStore.authenticate(authModel!);
                      if (authStore.value is SucessAuthState) {
                        navContext.pushNamedAndRemoveUntil(
                            '/home', ((route) => true));
                      } else if (authStore.value is ErrorAuthState) {
                        scaffoldContext.showSnackBar(
                          const SnackBar(
                            content: Text('Falha ao realizar o login'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      authModel = AuthModel(authStore.login!, authStore.pass!);
                      await authStore.register(authModel!);
                      if (authStore.value is SucessAuthState) {
                        navContext.pushNamedAndRemoveUntil(
                            '/home', ((route) => true));
                      } else if (authStore.value is ErrorAuthState) {
                        scaffoldContext.showSnackBar(
                          const SnackBar(
                            content: Text('Falha ao realizar o login'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                    ),
                    child: const Text('Registrar'),
                  )
                ],
              ));
  }
}
