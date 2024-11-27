import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StorySkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Skeletonizer.zone(
        child: Column(
          children: [
            Bone.circle(size: 60),
            Spacer(),
            Bone.text(
              width: 60,
            )
          ],
        ),
      ),
    );
  }
}
