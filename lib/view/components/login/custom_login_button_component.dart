import 'package:flutter/material.dart';
import 'package:system_finances/state/auth_state.dart';
import 'package:system_finances/stores/auth_store.dart';
import 'package:system_finances/view/pages/login_page.dart';

import '../../../constants/app_colors.dart';
import '../../../models/auth_model.dart';
import '../../widgets/custom_text_field_widget.dart';

class CustomLoginButtonComponent extends StatefulWidget {
  final AuthStore authStore;
  static bool isTextButton = true;

  const CustomLoginButtonComponent({
    Key? key,
    required this.authStore,
  }) : super(key: key);

  @override
  State<CustomLoginButtonComponent> createState() =>
      _CustomLoginButtonComponentState();
}

class _CustomLoginButtonComponentState
    extends State<CustomLoginButtonComponent> {
  @override
  Widget build(BuildContext context) {
    var navContext = Navigator.of(context);
    var scaffoldContext = ScaffoldMessenger.of(context);
    AuthModel? authModel;
    return ValueListenableBuilder<bool>(
      valueListenable: widget.authStore.inLoader,
      builder: (_, inLoader, __) => inLoader
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Visibility(
                  visible: !CustomLoginButtonComponent.isTextButton,
                  child: CustomTextFieldWidget(
                    onChanged: widget.authStore.setName,
                    label: 'Nome',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    authModel = AuthModel(
                        widget.authStore.login!, widget.authStore.pass!);
                    await widget.authStore.authenticate(authModel!);
                    if (widget.authStore.value is SucessAuthState) {
                      navContext.pushNamedAndRemoveUntil(
                          '/home', ((route) => true));
                    } else if (widget.authStore.value is ErrorAuthState) {
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
                Visibility(
                  visible: !CustomLoginButtonComponent.isTextButton,
                  child: ElevatedButton(
                    onPressed: () async {
                      authModel = AuthModel(
                          widget.authStore.login!, widget.authStore.pass!,
                          name: widget.authStore.name);
                      await widget.authStore.register(authModel!);
                      if (widget.authStore.value is SucessAuthState) {
                        navContext.pushNamedAndRemoveUntil(
                            '/home', ((route) => true));
                      } else if (widget.authStore.value is ErrorAuthState) {
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
                  ),
                ),
                Visibility(
                  visible: CustomLoginButtonComponent.isTextButton,
                  child: TextButton(
                      onPressed: () {
                        LoginPage.isVisible = true;
                        CustomLoginButtonComponent.isTextButton = false;
                        setState(() {});
                      },
                      child: const Text('Registrar')),
                ),
              ],
            ),
    );
  }
}
