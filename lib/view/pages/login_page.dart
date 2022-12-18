import 'package:flutter/material.dart';

import 'package:system_finances/repositories/auth_repository_imp.dart';

import 'package:system_finances/stores/auth_store.dart';

import '../components/login/custom_login_button_component.dart';
import '../widgets/custom_text_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthStore _controller = AuthStore(AuthRepositoryImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.people,
              size: MediaQuery.of(context).size.height * 0.3,
            ),
            CustomTextFieldWidget(
              onChanged: _controller.setLogin,
              label: 'Email',
            ),
            CustomTextFieldWidget(
              onChanged: _controller.setPass,
              label: 'Senha',
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomLoginButtonComponent(
              isLogin: true,
              label: 'Login',
              buttonColor: Colors.green,
              authStore: _controller,
            ),
            CustomLoginButtonComponent(
              isLogin: false,
              label: 'Register',
              buttonColor: Colors.blue,
              authStore: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
