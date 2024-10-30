import 'package:chat_box/core/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExternalAuthComponent extends StatelessWidget {
  const ExternalAuthComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (width - (3 * 48 + 100)) / 2, vertical: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppUtils.getIconPath(
                context,
                "facebook-logo",
              ),
              width: 48,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppUtils.getIconPath(
                context,
                "google-logo",
              ),
              width: 48,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppUtils.getIconPath(
                context,
                "apple-logo",
              ),
              width: 48,
            ),
          ),
        ],
      ),
    ));
  }
}
