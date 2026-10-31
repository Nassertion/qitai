
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchSuggestionsSkeleton extends StatelessWidget {
  const SearchSuggestionsSkeleton({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          children: [
            h16,

            // # Suggestion Content
            AppSkeleton(
              child: Row(
                children: [
                  const SizedBox(width: 16),

                  // # Suggestion Image
                  const Bone(
                    width: 44,
                    height: 44,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),

                  w12,

                  // # Suggestion Name
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Bone.text(
                        width: 140,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            h16,

            // # Divider
            Divider(
              color: AppColors.border,
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
