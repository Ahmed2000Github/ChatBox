import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: AppConstants.buttonHeight,
      width: AppConstants.buttonHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.onSurface),
        borderRadius: BorderRadius.circular(40),
      ),
      child: CircularProgressIndicator(
        color: theme.colorScheme.onSurface,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
