import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';

class VoiceCall extends StatelessWidget {
  const VoiceCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      body: Container(
        child: Column(
          children: [
            Spacer(),
            CircleAvatar(
              backgroundColor: theme.disabledColor,
              foregroundImage:
                  AssetImage("${AppConstants.imagesPath}person4.png"),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal:50),
              height: 60,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, 
                    
                  ),
                  Text(
                    "slide to answer",
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
