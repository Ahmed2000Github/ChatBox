import 'dart:convert';
import 'dart:io';

import 'package:chat_box/core/app_constants.dart';

class NetworkServices {
  final baseUrl = "http://192.168.139.1:9080/";

  static final NetworkServices instance = NetworkServices.private();

  NetworkServices.private();

  factory NetworkServices() {
    return instance;
  }

  Future<String?> uploadStoryFile(File file) async {
    final baseUrl = "http://192.168.139.1:9080/";
    final String uploadUrl = "${baseUrl}api/uploadStoryFile";
    print(uploadUrl);
    try {
      // Create HttpClient
      final HttpClient httpClient = HttpClient();

      // Open request
      final HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(uploadUrl));

      // Add headers
      request.headers.set(HttpHeaders.contentTypeHeader,
          'multipart/form-data; boundary=----FlutterBoundary');

      // Build multipart body
      final String boundary = "----FlutterBoundary";
      final List<int> bodyBytes = [];

      // Add file content to body
      bodyBytes.addAll(utf8.encode('--$boundary\r\n'));
      bodyBytes.addAll(utf8.encode(
          'Content-Disposition: form-data; name="storyFile"; filename="${file.path.split('/').last}"\r\n'));
      bodyBytes
          .addAll(utf8.encode('Content-Type: ${_getMimeType(file)}\r\n\r\n'));
      bodyBytes.addAll(await file.readAsBytes());
      bodyBytes.addAll(utf8.encode('\r\n--$boundary--\r\n'));

      // Write body to request
      request.add(bodyBytes);

      // Send request
      final HttpClientResponse response = await request.close();

      // Process response
      if (response.statusCode == 200) {
        final String responseBody =
            await response.transform(utf8.decoder).join();
        final path = jsonDecode(responseBody)['path'];
        print("Upload successful: $path");
        return path;
      } else {
        print("Failed to upload: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
    return null;
  }

  String _getMimeType(File file) {
    final extension = file.path.split('.').last.toLowerCase();

    if (!AppConstants.supportedVideoTypes.contains(extension)) {
      return 'application/octet-stream'; // Default MIME type for unsupported formats
    }

    switch (extension) {
      case 'mp4':
        return 'video/mp4';
      case 'mkv':
        return 'video/x-matroska';
      case 'mov':
        return 'video/quicktime';
      case 'avi':
        return 'video/x-msvideo';
      case 'webm':
        return 'video/webm';
      case 'flv':
        return 'video/x-flv';
      case 'wmv':
        return 'video/x-ms-wmv';
      case '3gp':
        return 'video/3gpp';
      case 'ogg':
        return 'video/ogg';
      default:
        return 'application/octet-stream'; // Fallback for edge cases
    }
  }
}
