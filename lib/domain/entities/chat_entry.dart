class ChatEntry {
  String id;
  String profileImage;
  String name;
  String lastMessage;
  int unReaded;
  String lastMessageSendAt;

  ChatEntry(
      {required this.id,
      required this.profileImage,
      required this.name,
      required this.lastMessage,
      required this.unReaded,
      required this.lastMessageSendAt});
}
