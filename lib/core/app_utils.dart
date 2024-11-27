import 'dart:convert';
import 'dart:io';

import 'package:chat_box/core/app_constants.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppUtils {
  static String getImagePath(BuildContext context, String name,
      {String extension = "svg"}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return "${AppConstants.imagesPath}$name-${isDarkMode ? "dark" : "light"}.$extension";
  }

  static String getIconPath(BuildContext context, String name,
      {String extension = "svg"}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return "${AppConstants.iconsPath}$name-${isDarkMode ? "dark" : "light"}.$extension";
  }

  static Future<String?> pickVideoFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? video = await picker.pickVideo(
        source: ImageSource.camera,
      );

      if (video != null) {
        return video.path;
      } else {
        print('No video recorded from camera.');
      }
    } catch (e) {
      print('Error picking video from camera: $e');
    }
    return null;
  }

  static Future<String?> pickVideoFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:
            AppConstants.supportedVideoTypes, // Allowed video formats
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        return filePath;
      } else {
        print('No video file selected.');
      }
    } catch (e) {
      print('Error picking video file from gallery: $e');
    }
    return null;
  }

  static Future<String?> extractFirstFrame(String videoPath) async {
    if (!File(videoPath).existsSync()) {
      print('Error: Video file does not exist at $videoPath');
      return null;
    }
    try {
      final directory = await getTemporaryDirectory();
      final outputPath = '${directory.path}/first_frame.jpg';
      final file = File(outputPath);
      if (await file.exists()) {
        await file.delete();
        print('File deleted successfully');
      }

      final command =
          '-i "$videoPath" -vf "thumbnail" -frames:v 1 -q:v 2 "$outputPath"';

      final session = await FFmpegKit.execute(command);

      final returnCode = await session.getReturnCode();
      if (returnCode?.isValueSuccess() ?? false) {
        print('First frame extracted successfully: $outputPath');
        return outputPath;
      } else {
        print('Failed to extract frame. Error code: $returnCode');
      }
    } catch (e) {
      print('Error extracting first frame: $e');
    }
    return null;
  }

  
}
