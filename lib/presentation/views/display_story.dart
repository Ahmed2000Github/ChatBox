import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/core/widgets/custom_loading.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:chat_box/presentation/components/user_avatar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class DisplayStory extends StatefulWidget {
  StoryEntity storyEntity;
  DisplayStory({super.key, required this.storyEntity});

  @override
  State<DisplayStory> createState() => _DisplayStoryState();
}

class _DisplayStoryState extends State<DisplayStory> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    final link = AppConstants.baseUrl + widget.storyEntity.mediaLink;
    print(link);
    _controller = VideoPlayerController.networkUrl(Uri.parse(link))
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          aspectRatio: _controller.value.aspectRatio,
        );
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final duration = DateTime.now().difference(widget.storyEntity.creationDate);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: _isInitialized
                          ? Chewie(controller: _chewieController)
                          : CustomLoading(
                              showBorder: false,
                              color: theme.colorScheme.onSurface,
                            ),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalPadding,
                        vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserAvatar(
                              url: widget.storyEntity.profileImage,
                              iconColor: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.storyEntity.name,
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${duration.inHours}h",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      color: Colors.white.withOpacity(.7)),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: AppConstants.iconButtonSize + 20),
                          child: Text(
                            widget.storyEntity.caption,
                            style: theme.textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: AppConstants.horizontalPadding,
              top: 10,
              child: SizedBox(
                width: AppConstants.iconButtonSize,
                height: AppConstants.iconButtonSize,
                child: FloatingActionButton(
                    heroTag: null,
                    shape: const CircleBorder(),
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppTheme.secondaryContainerColor,
                    child: SvgPicture.asset(
                      "${AppConstants.iconsPath}arrow-back.svg",
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
