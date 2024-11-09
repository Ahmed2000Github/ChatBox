import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/core/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class VoiceCall extends StatefulWidget {
  bool isExternalCaller;
  VoiceCall({super.key, required this.isExternalCaller});

  @override
  State<VoiceCall> createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  bool _isCalling = true;
  bool _isMicroOpen = true;
  bool _isSoundMute = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    widget.isExternalCaller
                        ? Navigator.pushReplacementNamed(
                            context, AppRoutes.home)
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
                  "Incoming call",
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  if (_isCalling)
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
                      child: _isCalling ? _getCallingBar() : _getRespondBar()),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  double buttonPosition = 0.0;
  bool _isDraging = false;

  _getCallingBar() {
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
                setState(() {
                  _isCalling = !(buttonPosition > availableWidth / 2 - 24);
                  _isDraging = false;
                  buttonPosition = 0;
                  ;
                });
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

  _getRespondBar() {
    final theme = Theme.of(context);
    return Row(
      children: [
        StatefulBuilder(builder: (context, setInnerState) {
          return FloatingActionButton(
            shape: CircleBorder(),
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
          );
        }),
        Spacer(),
        FloatingActionButton(
          shape: CircleBorder(),
          elevation: 0,
          onPressed: () {
            widget.isExternalCaller
                ? Navigator.pushReplacementNamed(context, AppRoutes.home)
                : Navigator.pop(context);
          },
          backgroundColor: theme.colorScheme.error,
          child: SvgPicture.asset(
            "${AppConstants.iconsPath}close.svg",
            color: Colors.white,
          ),
        ),
        Spacer(),
        StatefulBuilder(builder: (context, setInnerState) {
          return FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              setInnerState(() {
                _isSoundMute = !_isSoundMute;
              });
            },
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(.2),
            child: SvgPicture.asset(
              "${AppConstants.iconsPath}${_isSoundMute ? "no-sound" : "sound"}.svg",
              color: Colors.white,
            ),
          );
        }),
      ],
    );
  }
}
