import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/presentation/viewmodels/search_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class SearchContact extends ConsumerWidget {
  final searchContactViewModel =
      GetIt.I<StateNotifierProvider<SearchContactViewModel, List<Contact>>>();
  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final _contacts = ref.watch(searchContactViewModel);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 44,
                  margin: const EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding),
                  child: Row(
                    children: [
                       IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                            "${AppConstants.iconsPath}arrow-back.svg",
                            color: theme.colorScheme.onSurface,
                          )),
                      Expanded(
                        child: TextFormField(
                          controller: _searchTextController,
                          decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                              onTap: () {
                                final query = _searchTextController.text;
                                ref
                                    .watch(searchContactViewModel.notifier)
                                    .searchContacts(query);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  AppConstants.iconsPath + "search.svg",
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            suffixIcon: _searchTextController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchTextController.text = "";
                                      ref
                                          .watch(searchContactViewModel.notifier)
                                          .searchContacts('');
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        AppConstants.iconsPath + "close.svg",
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            hintText: 'Search',
                            hintStyle: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.disabledColor),
                            filled: true,
                            fillColor: theme.colorScheme.secondary.withOpacity(.5),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(12), // Set border radius here
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(12), // Set border radius here
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .watch(searchContactViewModel.notifier)
                                .searchContacts(value);
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              Expanded(
                  child: Container(
                      child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "People",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: (_contacts.length > 0)
                        ? ListView(
                            padding: EdgeInsets.only(
                                left: AppConstants.horizontalPadding,
                                right: AppConstants.horizontalPadding,
                                bottom: 10),
                            children: List.generate(_contacts.length, (index) {
                              final contact = _contacts[index];
                              return Column(
                                children: [
                                  if (index != 0) SizedBox(height: 30),
                                  _getContactItem(context, contact),
                                ],
                              );
                            }))
                        : Center(
                            child: Text(
                              "No Contact Found.",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.disabledColor),
                            ),
                          ),
                  ),
                ],
              )))
            ],
          ),
        ),
      ),
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
}
