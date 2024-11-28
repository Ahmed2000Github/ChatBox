import 'dart:io';
import 'dart:math';

import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/core/app_utils.dart';
import 'package:chat_box/core/widgets/custom_loading.dart';
import 'package:chat_box/domain/entities/story/create_story_entity.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/create_story_state.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/story_state.dart';
import 'package:chat_box/presentation/viewmodels/stories/create_story_view_model.dart';
import 'package:chat_box/presentation/viewmodels/stories/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class CreateStory extends ConsumerStatefulWidget {
  const CreateStory({super.key});

  @override
  ConsumerState<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends ConsumerState<CreateStory> {
  String? imagePath;
  String? _videoPath;
  bool _imageInProcess = false;
  late StateNotifierProvider<CreateStoryViewModel, CreateStoryState>
      createStoryViewModel;

  @override
  void initState() {
    super.initState();
    createStoryViewModel = GetIt.I<
        StateNotifierProvider<CreateStoryViewModel, CreateStoryState>>();
  }

  final _captionTextController = TextEditingController(text: "test");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final createStoryState = ref.watch(createStoryViewModel);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (createStoryState.isSuccess == null) return;
      if (createStoryState.isSuccess!) {
        final storyViewModel =
            GetIt.I<StateNotifierProvider<StoryViewModel, StoryState>>();
        ref.watch(storyViewModel.notifier).load();
        Navigator.pop(context);
      } else
        ref.watch(createStoryViewModel.notifier).resetState();
    });
    return Scaffold(
      body: Stack(
        children: [
          if (imagePath != null && !createStoryState.isLoading)
            SafeArea(
                child: SizedBox(
                    width: width,
                    height: height,
                    child: Image.file(
                      File(imagePath ?? ''),
                      fit: BoxFit.cover,
                    ))),
          Container(
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [],
                gradient: LinearGradient(
                    stops: [0, 100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor,
                      Colors.transparent
                    ])),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    height: 48,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalPadding),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              "${AppConstants.iconsPath}arrow-back.svg",
                              width: 24,
                              color: theme.textTheme.bodySmall!.color!,
                            )),
                        Spacer(),
                        if (imagePath != null && !createStoryState.isLoading)
                          SizedBox(
                            width: AppConstants.iconButtonSize,
                            height: AppConstants.iconButtonSize,
                            child: FloatingActionButton(
                                heroTag: null,
                                shape: const CircleBorder(),
                                elevation: 0,
                                onPressed: () {
                                  setState(() {
                                    imagePath = null;
                                  });
                                },
                                backgroundColor:
                                    AppTheme.secondaryContainerColor,
                                child: SvgPicture.asset(
                                    "${AppConstants.iconsPath}trash.svg")),
                          ),
                      ],
                    )),
                if (createStoryState.isLoading || _imageInProcess)
                  Expanded(
                      child: Center(
                    child: CustomLoading(
                      showBorder: false,
                      color: theme.colorScheme.onSurface,
                    ),
                  )),
                if (imagePath == null &&
                    !createStoryState.isLoading &&
                    !_imageInProcess)
                  Expanded(
                      child: Center(
                          child: TextButton(
                              onPressed: () async {
                                final result =
                                    await showVideoSourceDialog(context);
                                String? videoPath;
                                if (result == true) {
                                  videoPath =
                                      await AppUtils.pickVideoFromGallery();
                                } else if (result == false) {
                                  videoPath =
                                      await AppUtils.pickVideoFromCamera();
                                }
                                if (videoPath == null) return;
                                setState(() {
                                  _imageInProcess = true;
                                });
                                final thumbnailPath =
                                    await AppUtils.extractFirstFrame(videoPath);
                                setState(() {
                                  imagePath = thumbnailPath;
                                  _videoPath = videoPath;
                                  _imageInProcess = false;
                                });
                              },
                              child: Text(
                                "pick video",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))),
              ],
            ),
          ),
          if (!createStoryState.isLoading)
            Positioned(
              bottom: AppConstants.horizontalPadding,
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _captionTextController,
                          style: theme.textTheme.bodySmall,
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: theme.textTheme.bodySmall!
                                .copyWith(color: theme.disabledColor),
                            hintText: "Write your message",
                            fillColor: theme.colorScheme.secondary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Optional: add border radius
                              borderSide: BorderSide.none, // Removes the border
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.0),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: AppConstants.iconButtonSize,
                      height: AppConstants.iconButtonSize,
                      child: Opacity(
                        opacity: canSend ? 1 : .6,
                        child: FloatingActionButton(
                          onPressed: () {
                            if (!canSend) return;
                            final entity = CreateStoryEntity(
                                caption: _captionTextController.text,
                                tempPath: _videoPath ?? '');
                            ref
                                .watch(createStoryViewModel.notifier)
                                .create(entity);
                          },
                          elevation: 0,
                          shape: const CircleBorder(),
                          child: Transform.rotate(
                            angle: -pi / 4,
                            child: SvgPicture.asset(
                              "${AppConstants.iconsPath}send.svg",
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  bool get canSend =>
      _captionTextController.text.isNotEmpty && _videoPath != null;

  Future<bool?> showVideoSourceDialog(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          titlePadding:
              EdgeInsets.only(left: AppConstants.horizontalPadding, top: 10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Video Source',
                style: theme.textTheme.bodyLarge,
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true for gallery
                },
                icon: Icon(
                  Icons.video_camera_back_outlined,
                  color: theme.colorScheme.onSurface,
                ),
                label: Text(
                  'Gallery',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false for camera
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: theme.colorScheme.onSurface,
                ),
                label: Text(
                  'Camera',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null); // Return null for cancel
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
