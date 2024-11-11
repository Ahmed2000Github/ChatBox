import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/domain/entities/contact_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

class ContactsPage extends StatelessWidget {
  final _contacts = [
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
  List<ContactGroup> _contactsGroups = [];

  ContactsPage() {
    _contactsGroups = _generateGroups();
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
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchContact);
                },
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
                      color: theme.colorScheme.onSurface,
                    )),
              ),
              const Spacer(),
              Text(
                "Contacts",
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
                        "My Contact",
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
                        children:
                            List.generate(_contactsGroups.length, (index) {
                          final group = _contactsGroups[index];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  group.name,
                                  style: theme.textTheme.headlineMedium!.copyWith(
                                      color: theme.scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold,),
                                ),
                              ),
                              ...List.generate(group.items.length, (index) {
                                final contact = group.items[index];
                                return Column(
                                  children: [
                                    if(index!=0) SizedBox(height: 20),
                                    _getContactItem(context, contact),
                                  ],
                                );
                              })
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                )))
      ],
    );
  }

  Widget _getContactItem(BuildContext context, Contact item) {
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
                    item.imageProfile,
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
                        item.name,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.scaffoldBackgroundColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        item.description,
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.disabledColor,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            height: .1),
                      ),
                    ],
                  ),
                )),
                // Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _generateGroups() {
    List<ContactGroup> sortedGroup = [];

    for (var contact in _contacts) {
      final firstLetter = contact.name[0].toUpperCase();

      final group = sortedGroup.firstWhere(
        (item) => item.name == firstLetter,
        orElse: () {
          final newGroup = ContactGroup(name: firstLetter, items: []);
          sortedGroup.add(newGroup);
          return newGroup;
        },
      );

      group.items.add(contact);
    }

    for (var group in sortedGroup) {
      group.items.sort((a, b) => a.name.compareTo(b.name));
    }
    sortedGroup.sort((a, b) => a.name.compareTo(b.name));

    return sortedGroup;
  }
}
