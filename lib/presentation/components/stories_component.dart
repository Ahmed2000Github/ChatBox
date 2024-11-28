import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/domain/entities/story/story_entity.dart';
import 'package:chat_box/presentation/components/add_story_component.dart';
import 'package:chat_box/presentation/skeletons/story_skeleton.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/story_state.dart';
import 'package:chat_box/presentation/viewmodels/stories/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class StoriesComponent extends ConsumerWidget {
  StoriesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final avatarSize = 60.0;
    final storyViewModel =
        GetIt.I<StateNotifierProvider<StoryViewModel, StoryState>>();
    final storyState = ref.watch(storyViewModel);
    return Container(
      width: width,
      height: 82,
      margin: EdgeInsets.only(top: 36, bottom: 20),
      child: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        scrollDirection: Axis.horizontal,
        children: [
          AddStoryComponent(
            avatarSize: avatarSize,
          ),
          if (storyState.isLoading)
            ...List.generate(4, (index) {
              return StorySkeleton();
            }),
          if (!storyState.isLoading)
            ...List.generate(storyState.stories.length, (index) {
              final story = storyState.stories[index];
              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.displayStory,
                        arguments: story);
                  },
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              story.profileImage,
                              width: avatarSize,
                            ),
                          )),
                      Spacer(),
                      SizedBox(
                        width: 80,
                        child: Text(
                          story.name,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
        ],
      ),
    );
  }
}
