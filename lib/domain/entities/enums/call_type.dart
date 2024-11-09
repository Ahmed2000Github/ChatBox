import 'package:chat_box/core/app_constants.dart';

enum CallType {
  coming,
  outgoing,
  notResponded;

  String getPath() {
    final pathRoot = AppConstants.iconsPath;
    const ext = "_call.svg";
    switch (this) {
      case CallType.coming:
        return "${pathRoot}coming$ext";
      case CallType.outgoing:
        return "${pathRoot}outgoing$ext";
      case CallType.notResponded:
        return "${pathRoot}notResponded$ext";
    }
  }
}
