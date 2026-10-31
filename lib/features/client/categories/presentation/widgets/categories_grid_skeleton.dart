
import 'package:flutter/material.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesGridSkeleton extends StatelessWidget {
  const CategoriesGridSkeleton({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  // # Grid Layout
  static const gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.73,
      );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        return const _CategoryCardSkeleton();
      },
    );
  }
}

class _CategoryCardSkeleton extends StatelessWidget {
  const _CategoryCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // # Category Image
          const Expanded(
            child: Bone(
              width: double.infinity,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // # Category Name
          const Bone.text(
            width: 100,
            fontSize: 14,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
