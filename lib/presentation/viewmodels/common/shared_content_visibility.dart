import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedContentVisibility extends StateNotifier<bool> {
SharedContentVisibility() : super(false);

  void toggleVisibility() => state = !state;
}