
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileCardSkeleton extends StatelessWidget {
  const ProfileCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: AppSkeleton(
        child: const Row(
          children: [
            // # User Avatar
            Bone.circle(size: 44),

            SizedBox(width: 12),

            // # User Name
            Bone.text(
              width: 130,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
