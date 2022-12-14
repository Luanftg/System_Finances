import 'package:flutter/material.dart';
import 'package:system_finances/state/auth_state.dart';
import 'package:system_finances/stores/auth_store.dart';

import '../../../models/auth_model.dart';

class CustomLoginButtonComponent extends StatelessWidget {
  //final LoginController loginControler;
  final AuthStore authStore;
  final Color buttonColor;
  final String label;
  final bool isLogin;
  const CustomLoginButtonComponent({
    Key? key,
    required this.authStore,
    required this.buttonColor,
    required this.label,
    required this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navContext = Navigator.of(context);
    var scaffoldContext = ScaffoldMessenger.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: authStore.inLoader,
      builder: (_, inLoader, __) => inLoader
          ? const CircularProgressIndicator()
          : ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor)),
              onPressed: () async {
                var authModel = AuthModel(authStore.login!, authStore.pass!);
                isLogin
                    ? await authStore.authenticate(authModel)
                    : await authStore.register(authModel);

                if (authStore.value is SucessAuthState) {
                  navContext.pushReplacementNamed('/home');
                } else if (authStore.value is ErrorAuthState) {
                  scaffoldContext.showSnackBar(
                    const SnackBar(
                      content: Text('Falha ao realizar o login'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: Text(label),
            ),
    );
  }
}
