import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/core/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_box/core/app_providers.dart' show videoShowVisibility;

class VideoCalling extends ConsumerWidget {
  bool isExternalCaller;
  double buttonPosition = 0.0;
  bool _isDraging = false;

  VideoCalling({super.key, required this.isExternalCaller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 60),
            padding: EdgeInsets.symmetric(horizontal:AppConstants.horizontalPadding),
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  isExternalCaller
                      ? Navigator.pushReplacementNamed(context, AppRoutes.home)
                      : Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  "${AppConstants.iconsPath}arrow-back.svg",
                  color: theme.colorScheme.onSurface,
                )),
          ),
          Spacer(),
          Column(
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
              SizedBox(height: 5),
              Text(
                "Incoming video call",
                style: theme.textTheme.bodyLarge,
              )
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "${AppConstants.iconsPath}alarm.svg",
                          color: theme.colorScheme.onSurface,
                          width: 35,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Remind me",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        SvgPicture.asset(
                          AppUtils.getIconPath(context, "message-call"),
                          width: 35,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Message",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    height: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: _getCallingWidget(context, ref)),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  _getCallingWidget(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final startX = 56;
    final availableWidth = width - (2 * startX);
    final endX = startX + availableWidth;
    return StatefulBuilder(builder: (context, setInnerState) {
      return Stack(
        children: [
          Row(
            children: [
              SizedBox(height: 48, width: 48),
              Expanded(
                  child: AnimatedCrossFade(
                      duration: Duration(milliseconds: 100),
                      alignment: Alignment.center,
                      crossFadeState: _isDraging
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstCurve: Curves.easeInCirc,
                      firstChild: Center(
                        child: Text(
                          "slide to answer",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      secondChild: SizedBox.shrink())),
            ],
          ),
          Positioned(
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve:
                    Curves.easeInCirc, // Increase duration to 500 milliseconds
                height: 48,
                width: _isDraging ? availableWidth / 2 : 0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  borderRadius: BorderRadius.circular(50),
                ),
              )),
          Positioned(
            left: buttonPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setInnerState(() {
                  buttonPosition += details.delta.dx;
                  _isDraging = true;
                  if (buttonPosition < 0) buttonPosition = 0;
                  if (buttonPosition > availableWidth) {
                    buttonPosition = availableWidth - 48;
                  }
                });
              },
              onHorizontalDragEnd: (details) {
                final _isAnswered = buttonPosition > availableWidth / 2 - 24;
                ref.read(videoShowVisibility.notifier).state = _isAnswered;
                _isDraging = false;
                buttonPosition = 0;
              },
              child: SizedBox(
                height: 48,
                width: 48,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {}, // Optional additional tap logic
                  backgroundColor: AppTheme.callingColor,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "${AppConstants.iconsPath}call2.svg",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
