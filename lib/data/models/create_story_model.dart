// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateStoryModel {
  DateTime creationDate;
  String fileUrl;
  String caption;
  String userId;
  CreateStoryModel(
      {required this.creationDate,
      required this.fileUrl,
      required this.caption,
      required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationDate': creationDate.millisecondsSinceEpoch,
      'fileUrl': fileUrl,
      'caption': caption,
      'userId': userId,
    };
  }

  factory CreateStoryModel.fromMap(Map<String, dynamic> map) {
    return CreateStoryModel(
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      fileUrl: map['fileUrl'] as String,
      caption: map['caption'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateStoryModel.fromJson(String source) =>
      CreateStoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
