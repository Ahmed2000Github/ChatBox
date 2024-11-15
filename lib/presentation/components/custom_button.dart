import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  bool isLoading;
  void Function() onPressed;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: isLoading ? () {} : onPressed,
      child: Opacity(
        opacity: isLoading ? .7 : 1,
        child: Container(
          width: width - 2 * AppConstants.horizontalPadding,
          height: AppConstants.buttonHeight,
          decoration: BoxDecoration(
              color: backgroundColor ?? theme.primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: isLoading
                ? CustomLoading.withSizeAndNoBorder(
                    size: AppConstants.buttonHeight,
                    color: theme.scaffoldBackgroundColor)
                : Text(
                    text,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
