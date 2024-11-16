import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/widgets/custom_loading.dart';
import 'package:chat_box/presentation/viewmodels/authentication/app_initialization_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/app_initialization_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class Initial extends ConsumerStatefulWidget {
  const Initial({super.key});

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends ConsumerState<Initial> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appInitializationViewModel = GetIt.I<
          StateNotifierProvider<AppInitializationViewModel,
              AppInitializationState>>();
      ref.watch(appInitializationViewModel.notifier).init();
    });
  }


  void _initApp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appInitializationViewModel = GetIt.I<
          StateNotifierProvider<AppInitializationViewModel,
              AppInitializationState>>();
      final appInitializationState = ref.watch(appInitializationViewModel);

      if (appInitializationState.errorMessage?.isNotEmpty ?? false) return;
      if (appInitializationState.isLoggedIn == null) return;

      if (appInitializationState.isLoggedIn!) {
        final userInfosViewModel = GetIt.I<
            StateNotifierProvider<UserInfosViewModel, UserInfosState>>();
        ref.watch(userInfosViewModel.notifier).load();
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.welcome);
      }
      ref.watch(appInitializationViewModel.notifier).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    _initApp();
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Welcome",
              style: theme.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 80),
            CustomLoading.withSizeAndNoBorder(
              size: 50,
              color: theme.primaryColorLight,
            ),
            const Spacer(),
            Text(
              "ChatBox | version 1.0.0",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
