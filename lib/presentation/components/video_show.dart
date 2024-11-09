import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_box/core/app_providers.dart' show videoShowVisibility;

class VideoShow extends ConsumerStatefulWidget {
  bool isExternalCaller;
  VideoShow({super.key, required this.isExternalCaller});

  @override
  ConsumerState<VideoShow> createState() => _VideoShowState();
}

class _VideoShowState extends ConsumerState<VideoShow> {
  bool _isMicroOpen = true;

  bool _isSoundMute = false;

  bool _isVideoOff = false;

  bool _isCommingVideoOff = false;

  bool _isFrontCamera = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        if (_isCommingVideoOff)
          SizedBox(
            height: height,
            child: Image.asset(
              "${AppConstants.imagesPath}test-show1.png",
              fit: BoxFit.fill,
            ),
          ),
        if (!_isCommingVideoOff)
          SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: theme.disabledColor,
                    foregroundImage: AssetImage(
                      "${AppConstants.imagesPath}person4.png",
                    ),
                    radius: 63),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Borsha Akther",
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (!_isVideoOff)
          Positioned(
              top: 60,
              right: 30,
              child: Container(
                height: 100,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "${AppConstants.imagesPath}test-show1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              )),
        Positioned(
          bottom: 40,
          left: AppConstants.horizontalPadding,
          child: Container(
            width: width - 2 * AppConstants.horizontalPadding,
            child: Row(
              children: [
                StatefulBuilder(builder: (context, setInnerState) {
                  return SizedBox(
                    width: AppConstants.buttonHeight,
                    height: AppConstants.buttonHeight,
                    child: FloatingActionButton(
                      heroTag: null,
                      shape: const CircleBorder(),
                      onPressed: () {
                        setInnerState(() {
                          _isMicroOpen = !_isMicroOpen;
                        });
                      },
                      backgroundColor: Colors.white.withOpacity(.2),
                      elevation: 0,
                      child: SvgPicture.asset(
                        "${AppConstants.iconsPath}${_isMicroOpen ? "microphone" : "no-micro"}.svg",
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
                const Spacer(),
                StatefulBuilder(builder: (context, setInnerState) {
                  return SizedBox(
                    width: AppConstants.buttonHeight,
                    height: AppConstants.buttonHeight,
                    child: FloatingActionButton(
                      heroTag: null,
                      shape: const CircleBorder(),
                      onPressed: () {
                        setInnerState(() {
                          _isSoundMute = !_isSoundMute;
                        });
                      },
                      elevation: 0,
                      backgroundColor: AppTheme.secondaryContainerColor,
                      child: SvgPicture.asset(
                        "${AppConstants.iconsPath}${_isSoundMute ? "no-sound" : "sound"}.svg",
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
                const Spacer(),
                StatefulBuilder(builder: (context, setInnerState) {
                  return SizedBox(
                    width: AppConstants.buttonHeight,
                    height: AppConstants.buttonHeight,
                    child: FloatingActionButton(
                      heroTag: null,
                      shape: const CircleBorder(),
                      onPressed: () {
                        setState(() {
                          _isVideoOff = !_isVideoOff;
                        });
                      },
                      elevation: 0,
                      backgroundColor: AppTheme.secondaryContainerColor,
                      child: SvgPicture.asset(
                        "${AppConstants.iconsPath}${_isVideoOff ? "no-video" : "video"}.svg",
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
                const Spacer(),
                SizedBox(
                  width: AppConstants.buttonHeight,
                  height: AppConstants.buttonHeight,
                  child: FloatingActionButton(
                    heroTag: null,
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {
                        _isFrontCamera = !_isFrontCamera;
                      });
                    },
                    elevation: 0,
                    backgroundColor: AppTheme.secondaryContainerColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SvgPicture.asset(
                        "${AppConstants.iconsPath}rotate-camera.svg",
                        color: _isFrontCamera
                            ? theme.primaryColorLight
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: AppConstants.buttonHeight,
                  height: AppConstants.buttonHeight,
                  child: FloatingActionButton(
                    heroTag: null,
                    shape: const CircleBorder(),
                    elevation: 0,
                    onPressed: () {
                      widget.isExternalCaller
                          ? Navigator.pushReplacementNamed(
                              context, AppRoutes.home)
                          : Navigator.pop(context);
                      ref.read(videoShowVisibility.notifier).state = false;
                    },
                    backgroundColor: theme.colorScheme.error,
                    child: SvgPicture.asset(
                      "${AppConstants.iconsPath}close.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: AppConstants.horizontalPadding,
          child: IconButton(
              onPressed: () {
                widget.isExternalCaller
                    ? Navigator.pushReplacementNamed(context, AppRoutes.home)
                    : Navigator.pop(context);
                ref.read(videoShowVisibility.notifier).state = false;
              },
              icon: SvgPicture.asset(
                "${AppConstants.iconsPath}arrow-back.svg",
                color: theme.colorScheme.onSurface,
              )),
        )
      ],
    );
  }
}
