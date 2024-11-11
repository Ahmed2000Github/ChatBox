import 'package:chat_box/domain/entities/contact.dart';

class ContactGroup {
  String name;
  List<Contact> items;

  ContactGroup({required this.name, required this.items});
}
