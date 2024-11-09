import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/extensions/date_time.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/domain/entities/contact_call.dart';
import 'package:chat_box/domain/entities/enums/call_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

class CallsPage extends StatelessWidget {
  final _conatcts = [
    Contact(
        id: const Uuid().v1(),
        name: "Afrin Sabila",
        imageProfile: "${AppConstants.imagesPath}person2.png",
        email: "email@example.com",
        description: "Life is beautiful 👌"),
    Contact(
        id: const Uuid().v1(),
        name: "Adil Adnan",
        imageProfile: "${AppConstants.imagesPath}person3.png",
        email: "email@example.com",
        description: "Be your own hero 💪"),
    Contact(
        id: const Uuid().v1(),
        name: "John Borino",
        imageProfile: "${AppConstants.imagesPath}person1.png",
        email: "email@example.com",
        description: "Make yourself proud 😍"),
    Contact(
        id: const Uuid().v1(),
        name: "Bristy Haque",
        imageProfile: "${AppConstants.imagesPath}main-person.png",
        email: "email@example.com",
        description: "Keep working ✍"),
    Contact(
        id: const Uuid().v1(),
        name: "Borsha Akther",
        imageProfile: "${AppConstants.imagesPath}person4.png",
        email: "email@example.com",
        description: "Flowers are beautiful 🌸"),
  ];
  List<ContactCall> _contactCalls = [];

  CallsPage() {
    _contactCalls = [
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[0],
          date: DateTime.now(),
          type: CallType.coming),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[1],
          date: DateTime.now()
              .subtract(Duration(days: 3))
              .copyWith(hour: 19, minute: 35),
          type: CallType.coming),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[2],
          date: DateTime.now()
              .subtract(Duration(days: 1))
              .copyWith(hour: 19, minute: 35),
          type: CallType.notResponded),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[3],
          date: DateTime(2022, 7, 3, 7, 30),
          type: CallType.outgoing),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[4],
          date: DateTime.now(),
          type: CallType.notResponded),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[2],
          date: DateTime.now(),
          type: CallType.outgoing),
      ContactCall(
          id: const Uuid().v1(),
          destination: _conatcts[0],
          date: DateTime.now(),
          type: CallType.coming),
    ];
  }
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
              GestureDetector(
                onTap: () {},
                child: Container(
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
              ),
              const Spacer(),
              Text(
                "Calls",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                    height: 44,
                    width: 44,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    child: SvgPicture.asset(
                      AppConstants.iconsPath + "add-contact.svg",
                      color: theme.textTheme.bodySmall!.color,
                    )),
              ),
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalPadding,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recent",
                        style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.scaffoldBackgroundColor),
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
                        children: List.generate(_contactCalls.length, (index) {
                          final contactCall = _contactCalls[index];
                          final isLastIndex = index == _contactCalls.length - 1;
                          return _getCalLContactItem(
                              context, contactCall, isLastIndex);
                        }),
                      ),
                    ),
                  ],
                )))
      ],
    );
  }

  Widget _getCalLContactItem(
      BuildContext context, ContactCall item, bool isLastIndex) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Slidable(
          key: ValueKey(item.id),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  print(item.id);
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
          child: SizedBox(
            height: 52,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  foregroundImage: AssetImage(
                    item.destination.imageProfile,
                  ),
                  radius: 26,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.destination.name,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.scaffoldBackgroundColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(item.type.getPath()),
                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              item.date.toCustomFormattedString(),
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.disabledColor,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  height: .1),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                // Spacer(),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.voiceCall,
                      //     arguments: false);
                    },
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}call.svg",
                      color: theme.disabledColor,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.videoCall,
                      //     arguments: false);
                    },
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}video.svg",
                      color: theme.disabledColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLastIndex)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.only(left: 62),
            child: Divider(
              color: theme.disabledColor.withOpacity(.2),
            ),
          )
      ],
    );
  }
}
