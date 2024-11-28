import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/domain/entities/chat_entry.dart';
import 'package:chat_box/presentation/components/chat_list_item.dart';
import 'package:chat_box/presentation/components/stories_component.dart';
import 'package:chat_box/presentation/components/user_avatar.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class MessagesPage extends StatelessWidget {
  final _chatEntries = [
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person1.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 3,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person2.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 5,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person3.png",
        name: "John Borino",
        lastMessage: "Have a good day 🌸",
        unReaded: 0,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person1.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 0,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person2.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 0,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person2.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 0,
        lastMessageSendAt: "2 min ago"),
    ChatEntry(
        id: const Uuid().v1(),
        profileImage: "${AppConstants.imagesPath}person2.png",
        name: "Alex Linderson",
        lastMessage: "How are you today?",
        unReaded: 0,
        lastMessageSendAt: "2 min ago"),
  ];
  MessagesPage({Key? key}) : super(key: key);

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
              Container(
                  height: 44,
                  width: 44,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  child: SvgPicture.asset(
                    AppConstants.iconsPath + "search.svg",
                    color: theme.textTheme.bodySmall!.color,
                  )),
              const Spacer(),
              Text(
                "Home",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Consumer(builder: (context, ref, child) {
                final userInfosViewModel = GetIt.I<
                    StateNotifierProvider<UserInfosViewModel,
                        UserInfosState>>();
                final userInfosState = ref.watch(userInfosViewModel);
                final userImage = userInfosState.user?.profileImage;

                return UserAvatar(
                  url: userImage ?? "",
                );
              })
            ],
          ),
        ),
        StoriesComponent(),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: theme.textTheme.bodySmall!.color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                            color: theme.disabledColor,
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: AppConstants.horizontalPadding,
                            right: AppConstants.horizontalPadding,
                            bottom: 10),
                        children: _chatEntries.map((chatEntry) {
                          return ChatListItem(chatEntry: chatEntry);
                        }).toList(),
                      ),
                    ),
                  ],
                )))
      ],
    );
  }
}
