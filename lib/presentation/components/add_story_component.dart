import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/presentation/components/user_avatar.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class AddStoryComponent extends ConsumerWidget {
  final double avatarSize;
  AddStoryComponent({super.key, required this.avatarSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userInfosViewModel =
        GetIt.I<StateNotifierProvider<UserInfosViewModel, UserInfosState>>();
    final userInfosState = ref.watch(userInfosViewModel);
    final userImage = userInfosState.user?.profileImage ?? "";
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.createStory);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: avatarSize,
                  height: avatarSize,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      // color: theme.textTheme.bodySmall!.color,
                      border: Border.all(
                          color: theme.colorScheme.outline, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  child: UserAvatar(url: userImage)),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.textTheme.bodySmall!.color,
                      border: Border.all(
                          color: theme.scaffoldBackgroundColor, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Text(
            "My status",
            style: theme.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
