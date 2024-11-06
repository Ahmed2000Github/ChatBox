import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_providers.dart' show sharedContentVisibility;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Consumer, ConsumerWidget, WidgetRef;
import 'package:flutter_svg/svg.dart';

class ShareContent extends ConsumerWidget {
  final _sharedContentList = [
    SharedContentListItem(
        title: "Camera",
        descroption: "",
        image: "${AppConstants.iconsPath}camera.svg"),
    SharedContentListItem(
        title: "Documents",
        descroption: "Share your files",
        image: "${AppConstants.iconsPath}doc.svg"),
    SharedContentListItem(
        title: "Media",
        descroption: "Share photos and videos",
        image: "${AppConstants.iconsPath}media2.svg"),
    SharedContentListItem(
        title: "Contact",
        descroption: "Share your contacts",
        image: "${AppConstants.iconsPath}user.svg"),
    SharedContentListItem(
        title: "Location",
        descroption: "Share your location",
        image: "${AppConstants.iconsPath}location.svg"),
  ];
  ShareContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(sharedContentVisibility);
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.only(top: isOpen ? 0 : height),
      color: isOpen ? theme.colorScheme.onSurface.withOpacity(.2):Colors.transparent,
      child: Container(
        child: Container(
          margin: EdgeInsets.only(top: 240),
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Consumer(builder: (context, ref, child) {
                    final isOpen = ref.watch(sharedContentVisibility);
                    return IconButton(
                        onPressed: () {
                          ref.read(sharedContentVisibility.notifier).state =
                              !isOpen;
                        },
                        icon: Icon(Icons.close_rounded));
                  }),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Share Content",
                    style: theme.textTheme.bodyLarge,
                  )))
                ],
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: _sharedContentList.map((item) {
                  final isLastIndex = _sharedContentList.indexOf(item) ==
                      _sharedContentList.length - 1;
                  return SizedBox(
                    height: 104,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(44),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    item.image,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(.8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    textAlign: TextAlign.start,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (item.descroption.isNotEmpty)
                                    Text(
                                      item.descroption,
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(color: theme.disabledColor),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                        if (!isLastIndex)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.only(left: 52),
                            child: Divider(
                              color: theme.disabledColor,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SharedContentListItem {
  SharedContentListItem(
      {required this.title, required this.descroption, required this.image});

  String title;
  String descroption;
  String image;
}
