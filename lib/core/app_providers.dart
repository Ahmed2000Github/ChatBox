import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedContentVisibility = StateProvider<bool>((ref) => false);
final videoShowVisibility = StateProvider<bool>((ref) => false);
