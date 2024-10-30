import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/domain/entities/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
    
class StoriesComponent extends StatelessWidget {
  final _stories = [
    Story(id: "id", name: "Adil", profileImage: "${AppConstants.imagesPath}person1.png", mediaLink: "mediaLink", createdDate: DateTime.now()),
    Story(id: "id", name: "Marina", profileImage: "${AppConstants.imagesPath}person2.png", mediaLink: "mediaLink", createdDate: DateTime.now()),
    Story(id: "id", name: "Dean", profileImage: "${AppConstants.imagesPath}person3.png", mediaLink: "mediaLink", createdDate: DateTime.now()),
    Story(id: "id", name: "Max", profileImage: "${AppConstants.imagesPath}person1.png", mediaLink: "mediaLink", createdDate: DateTime.now()),
  ];
   StoriesComponent({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final avatarSize = 60.0;
    return Container(
      width: width,
      height: 82,
      margin: EdgeInsets.only(top: 36,bottom: 20),
      padding: EdgeInsets.only(left: AppConstants.horizontalPadding),
      child: ListView(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        children: [
          Column(
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
            ),
          ...List.generate(_stories.length, (index){
            final story = _stories[index];
            return Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          // color: theme.textTheme.bodySmall!.color,
                          border: Border.all(
                              color: theme.colorScheme.primary, width: 2),
                          borderRadius: BorderRadius.circular(40)),
                    child: Image.asset(story.profileImage,width: avatarSize,)
                  ),
                  Spacer(),
                  Text(
                    story.name,
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}