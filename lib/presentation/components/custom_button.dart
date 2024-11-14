import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';
    
class CustomButton extends StatelessWidget {
  
  final String text;
  final Color? backgroundColor;
  final double? textOpacity;

   const CustomButton({ super.key, required this.text,  this.backgroundColor,  this.textOpacity });
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return  Container(
            width: width - 2*AppConstants.horizontalPadding, 
            height: 48,
            decoration:BoxDecoration(
              color:backgroundColor ?? theme.primaryColor,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Center(
              child: Opacity(
                opacity: textOpacity??1,
                child: Text(text,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          );
  }
}