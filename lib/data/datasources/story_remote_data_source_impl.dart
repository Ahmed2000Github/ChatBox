import 'dart:io';

import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/network/network_services.dart';
import 'package:chat_box/data/datasources/interfaces/story_remote_data_source.dart';
import 'package:chat_box/data/models/create_story_model.dart';
import 'package:chat_box/data/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final NetworkServices networkServices = NetworkServices.instance;
  @override
  Future<bool> create(CreateStoryModel createStoryModel) async {
    createStoryModel.fileUrl =
        await networkServices.uploadStoryFile(File(createStoryModel.fileUrl)) ??
            "";

    print("ssssssssssssssssssssssss");
    print(createStoryModel.fileUrl);
    try {
      await firestore
          .collection(AppConstants.storiesCollection)
          .add(createStoryModel.toMap()); // Add document
      print("Data stored successfully!");
      return true;
    } catch (e) {
      print("Failed to store data: $e");
      return false;
    }
  }

  @override
  Future<List<StoryModel>> retrive() async {
    try {
      // Replace `AppConstants.storiesCollection` with your collection name
      final result =
          await firestore.collection(AppConstants.storiesCollection).get();

      // Iterate through the documents in the collection

      final stories = await Future.wait(result.docs.map((doc) async {
        final sender = (await firestore
                .collection(AppConstants.usersCollection)
                .where('email', isEqualTo: doc['userId'])
                .get())
            .docs
            .first
            .data();
        print("sender id : ${sender['name']}");
        final model = StoryModel(
            id: doc.id,
            creationDate:
                DateTime.fromMillisecondsSinceEpoch(doc['creationDate'] as int),
            name: sender['name'],
            profileImage: sender['profileImage'],
            fileUrl: doc['fileUrl']);
        return model;
      }).toList());
      return stories;
    } catch (e) {
      print('Error fetching data: $e');
    }
    return [];
  }
}
