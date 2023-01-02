import 'package:flutter/material.dart';

import 'package:system_finances/repositories/auth_repository_imp.dart';

import 'package:system_finances/stores/auth_store.dart';

import '../components/login/custom_login_button_component.dart';
import '../widgets/custom_text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static bool isVisible = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              size: MediaQuery.of(context).size.height * 0.2,
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
            // const SizedBox(
            //   height: 15,
            // ),
            CustomLoginButtonComponent(
              authStore: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
