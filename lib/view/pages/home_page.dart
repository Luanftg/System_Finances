import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_finances/constants/app_colors.dart';
import 'package:system_finances/main.dart';
import 'package:system_finances/services/internet_connection_checker_service.dart';

import 'package:system_finances/state/user_state.dart';
import 'package:system_finances/stores/user_store.dart';

import 'package:system_finances/view/widgets/custom_card_credit_widget.dart';
import 'package:system_finances/view/widgets/custom_menu_container_widget.dart';
import '../widgets/custom_card_home_widget.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({Key? key}) : super(key: key);

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserStore>().fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>();
    final state = store.value;
    Widget? child;
    final conection = InternetConnectionCheckerService.haveConnection();
    conection.then((value) {
      isConnected = value;
    });

    if (state is LoadindUserState) {
      child = const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (state is ErrorUserState) {
      child = Center(
        child: Text(state.message),
      );
    }

    if (state is SucessUserState) {
      final userLogged = state.user;
      child = Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: CustomMenuContainerWidget(user: userLogged)),
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomCardHomeWidget(
                    user: userLogged,
                  ),
                  const CustomCreditCard(),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white54,
      body: child ?? Container(),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        child: IconTheme(
          data: const IconThemeData(color: AppColors.grey),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/simulator');
                  },
                  icon: const Icon(Icons.compare_arrows),
                ),
                FloatingActionButton.small(
                  heroTag: 'hometag',
                  backgroundColor: AppColors.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onPressed: (() {}),
                  child: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bar_chart_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
