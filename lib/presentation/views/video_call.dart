import 'package:chat_box/presentation/components/video_calling.dart';
import 'package:chat_box/presentation/components/video_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/app_providers.dart' show videoShowVisibility;

class VideoCall extends ConsumerWidget {
    bool isExternalCaller;
  VideoCall({required this.isExternalCaller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final _isCalling = !ref.watch(videoShowVisibility);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: _isCalling ? VideoCalling(isExternalCaller:isExternalCaller) : VideoShow(isExternalCaller:isExternalCaller));
  }
}
