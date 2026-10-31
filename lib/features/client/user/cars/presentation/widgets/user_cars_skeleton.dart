
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserCarCardSkeleton extends StatelessWidget {
  const UserCarCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: AppSkeleton(
        child: Column(
          children: [
            // # Car Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Bone(
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),

                w16,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // # Car Name
                      const Bone.text(
                        width: double.infinity,
                        fontSize: 14,
                      ),

                      h8,

                      // # VIN
                      const Bone.text(
                        width: 125,
                        fontSize: 12,
                      ),

                      h8,

                      // # Vehicle Attributes
                      const Row(
                        children: [
                          Bone.text(width: 55, fontSize: 12),
                          SizedBox(width: 12),
                          Bone.text(width: 40, fontSize: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // # Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
                color: AppColors.border,
              ),
            ),

            // # Default Car And Delete
            const Row(
              children: [
                Bone.circle(size: 28),

                SizedBox(width: 8),

                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Bone.text(
                      width: 125,
                      fontSize: 13,
                    ),
                  ),
                ),

                Bone(
                  width: 20,
                  height: 20,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),

                SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserCarsSkeleton extends StatelessWidget {
  const UserCarsSkeleton({
    super.key,
    this.itemCount = 3,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 24,
      ),
      itemCount: itemCount,
      separatorBuilder: (_, _) => h16,
      itemBuilder: (context, index) {
        return const UserCarCardSkeleton();
      },
    );
  }
}
