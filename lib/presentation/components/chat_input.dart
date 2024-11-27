import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/core/app_providers.dart' show sharedContentVisibility;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ChatInput extends StatefulWidget {
  ChatInput({Key? key}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _messageTextController = TextEditingController();

  bool showSendButton = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 90,
      padding: EdgeInsets.only(right: 20,left: 5),
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(color: theme.primaryColor, spreadRadius: .5, blurRadius: 2)
          ]),
      child: Row(
        children: [
          Consumer(builder: (context, ref, child) {
            final isOpen = ref.watch(sharedContentVisibility);
              return IconButton(
                  onPressed: () {
                    ref.read(sharedContentVisibility.notifier).state = !isOpen;
                  },
                  icon: SvgPicture.asset(
                    "${AppConstants.iconsPath}media.svg",
                    color: theme.colorScheme.onSurface,
                  ));
            }
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: _messageTextController,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                  filled: true,
                  hintStyle: theme.textTheme.bodySmall!
                      .copyWith(color: theme.disabledColor),
                  hintText: "Write your message",
                  fillColor: theme.colorScheme.secondary.withOpacity(.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Optional: add border radius
                    borderSide: BorderSide.none, // Removes the border
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "${AppConstants.iconsPath}files.svg",
                        color: theme.disabledColor,
                      )),
                ),
                onChanged: (value) {
                  setState(() {
                  showSendButton = value.isNotEmpty;
                  });
                },
              ),
            ),
          ),
          if (!showSendButton)
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}camera.svg",
                      color: theme.colorScheme.onSurface,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}microphone.svg",
                      color: theme.colorScheme.onSurface,
                    )),
              ],
            ),
          if (showSendButton)
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: AppConstants.iconButtonSize,
                  height:  AppConstants.iconButtonSize,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    shape: const CircleBorder(),
                    child: SvgPicture.asset(
                      "${AppConstants.iconsPath}send.svg",
                      // color: theme.colorScheme.onSurface,
                      width: 20,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
