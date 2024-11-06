import 'package:chat_box/core/app_theme.dart';
import 'package:flutter/material.dart';
    
class AvatarWithStatus extends StatelessWidget {

   String image;
   double size;
   bool status;

   AvatarWithStatus({ super.key,required this.image, this.size = 30, this.status = false });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child:  Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.canvasColor,
                    foregroundImage: AssetImage(image),
                    radius: size,
                  ),
                  Positioned(
                    bottom: (size * 2) / 30,
                    right: (size*5)/30,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: status ?AppTheme.onlineColor:theme.disabledColor,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  )
                ],
              ),
    );
  }
}