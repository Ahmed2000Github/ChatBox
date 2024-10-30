import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  String text;

  TextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodySmall;
    return  Row(
      children: [
        // Left Divider
        const Expanded(
          child: Divider(
            thickness: 1, // Set the thickness of the line
            color: Colors.grey, // Customize the color of the divider
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: textTheme,
          ),
        ),
        // Right Divider
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

