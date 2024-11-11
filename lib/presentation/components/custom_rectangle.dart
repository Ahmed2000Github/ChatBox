import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {
  const CustomRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
            color: theme.disabledColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
