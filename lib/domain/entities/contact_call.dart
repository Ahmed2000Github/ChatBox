import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/domain/entities/enums/call_type.dart';

class ContactCall {
  String id;
  Contact destination;
  DateTime date;
  CallType type;

  ContactCall(
      {required this.id,
      required this.destination,
      required this.date,
      required this.type});
}
