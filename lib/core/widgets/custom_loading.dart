import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final bool showBorder;
  Color? color;

  // Default constructor
  CustomLoading(
      {super.key,
      this.size = AppConstants.buttonHeight,
      this.color,
      this.showBorder = true});

  // Factory constructor
  factory CustomLoading.withSizeAndNoBorder(
      {required double size, Color? color}) {
    return CustomLoading(size: size, showBorder: false, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border:
            showBorder ? Border.all(color: theme.colorScheme.onSurface) : null,
        borderRadius: BorderRadius.circular(40),
      ),
      child: CircularProgressIndicator(
        color: color ?? theme.colorScheme.onSurface,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
