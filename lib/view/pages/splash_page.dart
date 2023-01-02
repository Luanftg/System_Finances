import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/stores/splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashStore _splashStore = SplashStore();
  @override
  void initState() {
    super.initState();

    Future.wait({
      _splashStore.isAuthenticated(),
      Future.delayed(const Duration(seconds: 2))
    }).then((value) => value[0]
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => true)
        : Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => true));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.white54,
        ),
      ),
    );
  }
}
