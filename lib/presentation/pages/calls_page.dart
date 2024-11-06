import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:waved_audio_player/waved_audio_player.dart';
import 'package:flutter/material.dart';

class CallsPage extends StatefulWidget {
  CallsPage({Key? key}) : super(key: key);

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  String filePath = "";

  Future<void> pickFile() async {
    String? _filePath = await FilePicker.platform
        .pickFiles(type: FileType.audio)
        .then((result) => result?.files.first.path);

    if (_filePath != null) {
      // Use the filePath to load audio
      setState(() {
        filePath = _filePath;
      });
      print("Selected file path: $filePath");
    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text("calls")
    );
  }
}
