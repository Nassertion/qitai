
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoriesSkeleton extends StatelessWidget {
  const HomeCategoriesSkeleton({
    super.key,
    this.categoryCount = 5,
  });

  final int categoryCount;

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: SizedBox(
        height: 95,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
          ),
          itemCount: categoryCount,
          separatorBuilder: (_, _) => w12,
          itemBuilder: (context, index) {
            return const Column(
              children: [
                // # Category Image
                Bone(
                  width: 74,
                  height: 56,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),

                SizedBox(height: 8),

                // # Category Name
                Bone.text(
                  width: 65,
                  fontSize: 12,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
