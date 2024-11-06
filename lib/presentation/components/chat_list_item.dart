import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/domain/entities/chat_entry.dart';
import 'package:chat_box/presentation/components/avatar_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatListItem extends StatelessWidget {
  ChatEntry chatEntry;

  ChatListItem({super.key, required this.chatEntry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.conversation);
      },
      child: Slidable(
        key: ValueKey(chatEntry.id),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            Spacer(),
            GestureDetector(
              onTap: () {
                print(chatEntry.id);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: SvgPicture.asset("${AppConstants.iconsPath}notification.svg",
                color: theme.textTheme.bodySmall!.color,),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print(chatEntry.id);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    borderRadius: BorderRadius.circular(40)),
                child: SvgPicture.asset("${AppConstants.iconsPath}trash.svg"),
              ),
            ),
           Spacer(),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(top: 25),
          height: 52,
          child: Row(
            children: [
             AvatarWithStatus(
              image: chatEntry.profileImage,
              status: true,
             ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chatEntry.name,
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: theme.scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    chatEntry.lastMessage,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.disabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )),
              Column(
                children: [
                  Text(
                    chatEntry.lastMessageSendAt,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.disabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (chatEntry.unReaded > 0)
                    Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        chatEntry.unReaded.toString(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          height: 2.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
