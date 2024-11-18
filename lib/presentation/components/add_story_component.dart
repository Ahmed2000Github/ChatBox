import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';
    
class AddStoryComponent extends StatelessWidget {


  final double avatarSize;
  const AddStoryComponent({ super.key, required this.avatarSize });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: avatarSize ,
                      height: avatarSize,
                      padding: EdgeInsets.all(2),
                       decoration: BoxDecoration(
                        // color: theme.textTheme.bodySmall!.color,
                        border: Border.all(
                            color: theme.colorScheme.outline, width: 2),
                        borderRadius: BorderRadius.circular(40)),
                      child: CircleAvatar(
                        backgroundColor: theme.canvasColor,
                        foregroundImage: AssetImage(
                            "${AppConstants.imagesPath}main-person.png"),
                      )),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration:BoxDecoration(
                          color: theme.textTheme.bodySmall!.color,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: 
                        Icon(Icons.add,
                        size: 20,
                      color: theme.scaffoldBackgroundColor,
                                          ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Text(
                  "My status",
                  style: theme.textTheme.bodyMedium,
                )
              ],
            );
  }
}