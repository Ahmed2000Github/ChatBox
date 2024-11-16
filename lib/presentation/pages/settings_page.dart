import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/widgets/custom_rectangle.dart';
import 'package:chat_box/presentation/viewmodels/authentication/logout_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/logout_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/core/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  final _settings = [
    SettingsListItem(
        title: "Account",
        description: "Privacy, security, change number",
        iconPath: "${AppConstants.iconsPath}key.svg",
        targetPage: "targetPage"),
    SettingsListItem(
        title: "Chat",
        description: "Chat history,theme,wallpapers",
        iconPath: "${AppConstants.iconsPath}message.svg",
        targetPage: "targetPage"),
    SettingsListItem(
        title: "Notifications",
        description: "Messages, group and others",
        iconPath: "${AppConstants.iconsPath}notification.svg",
        targetPage: "targetPage"),
    SettingsListItem(
        title: "Help",
        description: "Help center,contact us, privacy policy",
        iconPath: "${AppConstants.iconsPath}help.svg",
        targetPage: "targetPage"),
    SettingsListItem(
        title: "Storage and data",
        description: "Network usage, stogare usage",
        iconPath: "${AppConstants.iconsPath}sync.svg",
        targetPage: "targetPage"),
    SettingsListItem(
        title: "Invite a friend",
        description: "",
        iconPath: "${AppConstants.iconsPath}friend.svg",
        targetPage: "targetPage"),
  ];

  void Function(int) onBack;

  SettingsPage({required this.onBack});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(top: 20),
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    onBack(0);
                  },
                  icon: SvgPicture.asset(
                    "${AppConstants.iconsPath}arrow-back.svg",
                    color: theme.colorScheme.onSurface,
                  )),
              const Spacer(),
              Text(
                "Settings",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: theme.textTheme.bodySmall!.color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    CustomRectangle(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer(builder: (context, ref, child) {
                      final userInfosViewModel = GetIt.I<
                          StateNotifierProvider<UserInfosViewModel,
                              UserInfosState>>();
                      final userInfosState = ref.watch(userInfosViewModel);
                      final userImage = userInfosState.user?.profileImage;
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppConstants.horizontalPadding),
                        child: Row(
                          children: [
                            ClipOval(
                              child: userInfosState.isLoading
                                  ? null // Optionally show a loading indicator
                                  : userImage != null
                                      ? Image.network(
                                          userImage,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : SvgPicture.asset(
                                          "${AppConstants.iconsPath}user.svg",
                                          width: 60,
                                          height: 60,
                                          color: theme.scaffoldBackgroundColor,
                                        ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userInfosState.user?.name ?? "",
                                    style:
                                        theme.textTheme.headlineSmall!.copyWith(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    userInfosState.user?.description ?? "",
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: theme.disabledColor,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        height: .1),
                                  ),
                                ],
                              ),
                            )),
                             Consumer(builder: (context, ref, child) {
                              final logOutViewModel = GetIt.I<
                                  StateNotifierProvider<LogOutViewModel,
                                      LogOutState>>();
                              final logOutState = ref.watch(logOutViewModel);
                              if(logOutState.isSuccess){
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.welcome, (route)=>false);
                                  ref.watch(logOutViewModel.notifier).resetState();
                                });
                              }
                              return GestureDetector(
                                onTap: () => ref.watch(logOutViewModel.notifier)(),
                                child: SvgPicture.asset(
                                  "${AppConstants.iconsPath}qr-code.svg",
                                  width: 24,
                                ),
                              );
                            })
                          ],
                        ),
                      );
                    }),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          color: theme.disabledColor.withOpacity(.2),
                        )),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: AppConstants.horizontalPadding,
                            right: AppConstants.horizontalPadding,
                            bottom: 10),
                        children: List.generate(_settings.length, (index) {
                          final settingItem = _settings[index];
                          return _getSettingsItem(context, settingItem);
                        }),
                      ),
                    ),
                  ],
                )))
      ],
    );
  }

  Widget _getSettingsItem(BuildContext context, SettingsListItem item) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            print(item.targetPage);
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Container(
                  height: AppConstants.iconButtonSize,
                  width: AppConstants.iconButtonSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44),
                      color: theme.colorScheme.inverseSurface),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      item.iconPath,
                      color: theme.disabledColor.withOpacity(.8),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.scaffoldBackgroundColor),
                      ),
                      if (item.description.isNotEmpty)
                        Text(
                          item.description,
                          style: theme.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.disabledColor.withOpacity(.8)),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsListItem {
  String title;
  String description;
  String iconPath;
  String targetPage;

  SettingsListItem(
      {required this.title,
      required this.description,
      required this.iconPath,
      required this.targetPage});
}
