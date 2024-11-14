import 'package:chat_box/domain/entities/enums/message_type.dart';

class Message {
  Message({
    required this.id,
    required this.textContent,
    required this.senderId,
    required this.type,
    required this.sentDateTime,
    this.mediaLink
  });
 String id;
 String textContent;
 String senderId;
 String? mediaLink;
 MessageType type;
 DateTime sentDateTime;
 

@override
String toString() {
    return 'Message{id=$id, textContent=$textContent, senderId=$senderId, mediaLink=$mediaLink, type=$type, sentDateTime=$sentDateTime}';
  }
}

