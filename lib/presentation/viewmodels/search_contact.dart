
import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SearchContactViewModel extends StateNotifier<List<Contact>> {
  final _allContacts = [
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


  SearchContactViewModel() : super([]) {
    state = _allContacts;
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      state = _allContacts;
    } else {
      state = _allContacts
          .where((contact) =>
              contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
