import 'package:audioplayers/audioplayers.dart';
import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/extensions/date_time.dart';
import 'package:chat_box/domain/entities/message.dart';
import 'package:chat_box/domain/message_type.dart';
import 'package:chat_box/presentation/components/avatar_with_status.dart';
import 'package:chat_box/presentation/components/chat_input.dart';
import 'package:chat_box/presentation/components/share_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:waved_audio_player/waved_audio_player.dart';

class Conversation extends StatefulWidget {
  Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final _messages = [
    Message(
        id: const Uuid().v1(),
        textContent: "Hello! Jhon abraham",
        senderId: "me",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent:
            "Hello ! Nazrul How are you? Hello! Jhon abraham Hello! Jhon abraham Hello! Jhon abraham Hello! Jhon abraham Hello! Jhon abraham Hello! Jhon abraham",
        senderId: "friend",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "You did your job well!",
        senderId: "me",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "Have a great working week!!",
        senderId: "friend",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "Hope you like it",
        senderId: "friend",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "",
        mediaLink: "assets/test/audio.mp3",
        senderId: "me",
        type: MessageType.AUDIO,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "Look at my work man!!",
        senderId: "friend",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "",
        mediaLink: "assets/images/image1.png",
        senderId: "friend",
        type: MessageType.IMAGE,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "",
        mediaLink: "assets/images/image2.png",
        senderId: "friend",
        type: MessageType.IMAGE,
        sentDateTime: DateTime.now()),
    Message(
        id: const Uuid().v1(),
        textContent: "You did your job well!",
        senderId: "me",
        type: MessageType.TEXT,
        sentDateTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              "${AppConstants.iconsPath}arrow-back.svg",
                              color: theme.colorScheme.onSurface,
                            )),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        AvatarWithStatus(
                          image: "${AppConstants.imagesPath}person3.png",
                          status: true,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jhon Abraham",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                // height: 0.9,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Active now",
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: theme.disabledColor,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "${AppConstants.iconsPath}call2.svg",
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "${AppConstants.iconsPath}video.svg",
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalPadding),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: List.generate(_messages.length, (index) {
                        final message = _messages[index];
                        final isCurrentUser = message.senderId == "me";
                        final _key = GlobalKey();
                        var _timeWidth = double.infinity;
                        return Column(
                          children: [
                            if (index == 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 4),
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    "Today",
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            Align(
                              alignment: isCurrentUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: isCurrentUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isCurrentUser)
                                    CircleAvatar(
                                      backgroundColor: theme.canvasColor,
                                      foregroundImage: AssetImage(
                                          "${AppConstants.imagesPath}person3.png"),
                                      radius: 20,
                                    ),
                                  if (!isCurrentUser)
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: (2 * width) / 3, minWidth: 40),
                                    child: Column(
                                      crossAxisAlignment: isCurrentUser
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (!isCurrentUser)
                                          Text(
                                            "Jhon Abraham",
                                            style: theme.textTheme.headlineSmall,
                                          ),
                                        Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            key: _key,
                                            decoration: BoxDecoration(
                                                color: isCurrentUser
                                                    ? theme.primaryColor
                                                    : theme.colorScheme.secondary,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        isCurrentUser ? 15 : 0),
                                                    topRight: Radius.circular(
                                                        isCurrentUser ? 0 : 15),
                                                    bottomLeft:
                                                        const Radius.circular(15),
                                                    bottomRight:
                                                        const Radius.circular(15))),
                                            child: _getMessage(
                                                message, isCurrentUser)),
                                        StatefulBuilder(
                                            builder: (context, setInnerState) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            final size =
                                                _key.currentContext?.size;
                                            if (size != null) {
                                              final _width = size.width;
                                              setInnerState(() {
                                                _timeWidth =
                                                    _width > 60 ? _width : 60;
                                              });
                                            }
                                          });
                                          return Container(
                                            width: _timeWidth,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              message.sentDateTime.toTimeFormat(),
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                color: theme.disabledColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                ChatInput(),
              ]
            ),
            ShareContent()
          ],
        ),
      ),
    );
  }

  _getMessage(Message message, bool isCurrentUser) {
    final theme = Theme.of(context);
    switch (message.type) {
      case MessageType.IMAGE:
        print(message.toString());
        return _getImageMessage(message.mediaLink!);
      case MessageType.AUDIO:
        return _getAudioMessage(message.mediaLink!, isCurrentUser);
      default:
        return Text(
          message.textContent,
          style: theme.textTheme.bodySmall!.copyWith(
            color:
                isCurrentUser ? Colors.white : theme.textTheme.bodySmall!.color,
            fontWeight: FontWeight.bold,
          ),
        );
    }
  }

  _getAudioMessage(String link, bool isCurrentUser) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return WavedAudioPlayer(
      source: AssetSource(link),
      unplayedColor: theme.primaryColorLight,
      playedColor: isCurrentUser ? Colors.white : theme.colorScheme.onSurface,
      waveHeight: 20,
      buttonSize: 30,
      iconColor: theme.primaryColor,
      waveWidth: ((2 * width) / 3) - 110,
      timingStyle: theme.textTheme.bodyMedium!.copyWith(
        height: 0,
        color:  isCurrentUser ? Colors.white : theme.colorScheme.onSurface
      ),
      onError: (p0) {
        print(p0.message);
      },
    );
  }

  _getImageMessage(String link) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0), child: Image.asset(link));
  }
}
