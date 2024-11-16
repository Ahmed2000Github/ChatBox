import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/presentation/viewmodels/authentication/email_verification_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/email_verification_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class EmailVerification extends ConsumerWidget {
  const EmailVerification({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final emailVerificationViewModel = GetIt.I<
          StateNotifierProvider<EmailVerificationViewModel,
              EmailVerificationState>>();
      final emailVerificationState = ref.watch(emailVerificationViewModel);
      if (emailVerificationState.isSuccess == null) return;
      if (emailVerificationState.isSuccess!) {
        final userInfosViewModel = GetIt.I<
            StateNotifierProvider<UserInfosViewModel, UserInfosState>>();
        ref.watch(userInfosViewModel.notifier).load();
        Navigator.pushNamed(context, AppRoutes.home);
      } else
        Navigator.pop(context);
      ref.watch(emailVerificationViewModel.notifier).resetState();
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding, vertical: 20),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                height: 48,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}arrow-back.svg",
                      width: 24,
                      color: theme.textTheme.bodySmall!.color!,
                    ))),
            Stack(
              children: [
                Positioned(
                    top: 17,
                    child: Container(
                      height: 10,
                      width: 50,
                      color: AppConstants.barColor,
                    )),
                Text(
                  "Email Verification",
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Waiting for email verification. Verify your email to start chatting with friends and family today",
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.disabledColor),
            ),
            Expanded(
                child: Center(
              child: Text(
                "Waiting for Verification...",
                style: theme.textTheme.headlineSmall!
                    .copyWith(color: theme.disabledColor),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
