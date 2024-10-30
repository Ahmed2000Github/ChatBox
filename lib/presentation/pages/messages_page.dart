import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/presentation/components/stories_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
    
class MessagesPage extends StatelessWidget {

  const MessagesPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return     Column(
          children: [
            Container(
              height: 44,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal:AppConstants.horizontalPadding),
              child: Row(
                children: [
                  Container(
                      height: 44,
                      width: 44,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: SvgPicture.asset(
                        AppConstants.iconsPath + "search.svg",
                      )),
                  Spacer(),
                  Text(
                    "Home",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Image.asset(AppConstants.imagesPath + "main-person.png")
                ],
              ),
            ),
            StoriesComponent(),
            Expanded(child: 
            Container(
              decoration:BoxDecoration(
                color:theme.textTheme.bodySmall!.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
            ))
          ],
        );
  }
}