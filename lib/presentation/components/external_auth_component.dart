import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_utils.dart';
import 'package:chat_box/core/widgets/custom_loading.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_in_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_in_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/svg.dart';

class ExternalAuthComponent extends ConsumerWidget {
  const ExternalAuthComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (width - (3 * 48 + 100)) / 2, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getIconWidget<FacebookSignInState>(context, ref, "facebook-logo"),
          const SizedBox(width: 20),
          _getIconWidget<GoogleSignInState>(context, ref, "google-logo")
        ],
      ),
    ));
  }

  _getIconWidget<T>(
    BuildContext context,
    WidgetRef ref,
    String logoName,
  ) {
    final signInViewModel =
        GetIt.I<StateNotifierProvider<SignInViewModel, SignInState>>();
    SignInState signInState = ref.watch(signInViewModel);
    signInState = (signInState is T) ? signInState : SignInState();
     print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
     print(signInState.isSuccess);
     print(signInState.isLoading);
     print(signInState.errorMessage);
     print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    if (signInState.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final userInfosViewModel = GetIt.I<
            StateNotifierProvider<UserInfosViewModel, UserInfosState>>();
        ref.watch(userInfosViewModel.notifier).load();
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (route) => false);
        ref.watch(signInViewModel.notifier).resetState();
      });
    }
    
    final signIn = (T == GoogleSignInState)
        ? ref.watch(signInViewModel.notifier).googleSignIn
        : ref.watch(signInViewModel.notifier).facebookSignIn;
    return IconButton(
        onPressed: () => signInState.isLoading ? {} : signIn(),
        icon: AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: signInState.isLoading
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: SvgPicture.asset(
              AppUtils.getIconPath(
                context,
                logoName,
              ),
              width: 48,
            ),
            secondChild: const CustomLoading()));
  }
}
