import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchCardProductSkeleton extends StatelessWidget {
  const SearchCardProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: AppSkeleton(
        child: Row(
          children: [
            // # Product Image
            const Bone(
              width: 95,
              height: 95,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),

            w12,

            // # Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // # Product Name
                  const Bone.text(width: double.infinity, fontSize: 14),

                  h4,

                  // # Part Number
                  const Bone.text(width: 100, fontSize: 12),

                  h16,

                  // # Price And Add Button
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bone.text(width: 65, fontSize: 15),
                      Bone.square(
                        size: 32,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchProductsSkeleton extends StatelessWidget {
  const SearchProductsSkeleton({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, _) => h8,
      itemBuilder: (context, index) {
        return const SearchCardProductSkeleton();
      },
    );
  }
}
