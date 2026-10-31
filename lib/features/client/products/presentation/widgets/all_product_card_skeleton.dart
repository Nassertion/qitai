import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllProductCardSkeleton extends StatelessWidget {
  const AllProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFE8EAED),
        highlightColor: Color(0xFFF8F9FA),
        duration: Duration(milliseconds: 1200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Bone(
            height: 163,
            width: double.infinity,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),

          h8,

          const Bone.text(width: 130, fontSize: 13),

          h4,

          const Bone.text(width: 100, fontSize: 12),

          h8,

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
    );
  }
}
