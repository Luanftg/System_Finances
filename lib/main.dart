import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/repositories/home_repository_implementation.dart';
import 'package:system_finances/stores/user_store.dart';

import 'package:system_finances/view/pages/home_page.dart';
import 'package:system_finances/view/pages/login_page.dart';
import 'package:system_finances/view/pages/simulator_page.dart';
import 'package:system_finances/view/pages/splash_page.dart';

import 'constants/app_text_styles.dart';
import 'firebase_options.dart';

// ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);
bool isConnected = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserStore(HomeRepositoryImpementation())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePageV2(),
          '/simulator': (context) => const SimulatorPage(),
        },
        theme: ThemeData(
          colorSchemeSeed: AppColors.primary,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12))),
          ),
          textTheme: const TextTheme(labelMedium: AppTextStyles.label),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
