
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllProductCardSkeleton extends StatelessWidget {
  const AllProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // # Product Image
          const Bone(
            height: 163,
            width: double.infinity,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),

          h8,

          // # Product Name
          const Bone.text(
            width: 130,
            fontSize: 13,
          ),

          h4,

          // # Part Number
          const Bone.text(
            width: 100,
            fontSize: 12,
          ),

          h8,

          // # Price And Add Button
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bone.text(
                width: 65,
                fontSize: 15,
              ),
              Bone.square(
                size: 32,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
