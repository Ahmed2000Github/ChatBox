import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoShowVisibility extends StateNotifier<bool> {
  VideoShowVisibility() : super(false);

  void toggleVisibility() => state = !state;
}
