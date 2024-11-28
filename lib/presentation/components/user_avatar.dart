import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserAvatar extends StatelessWidget {
  String url;
  double? size;
  Color? iconColor;

  UserAvatar({super.key, required this.url,this.size,this.iconColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipOval(
      child: // Optionally show a loading indicator
          url.isNotEmpty
              ? Image.network(
                  url,
                  width: size??AppConstants.iconButtonSize,
                  height: size??AppConstants.iconButtonSize,
                  fit: BoxFit.cover,
                )
              : SvgPicture.asset(
                  "${AppConstants.iconsPath}user.svg",
                  width: size??AppConstants.iconButtonSize,
                  height: size??AppConstants.iconButtonSize,
                  color: iconColor?? theme.colorScheme.onSurface,
                ),
    );
  }
}
