import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // # Product Image
        AppSkeleton(
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Bone(
                      width: 210,
                      height: 185,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),

              // # Page Indicator
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bone.circle(size: 6),
                  SizedBox(width: 6),
                  Bone.circle(size: 6),
                ],
              ),
            ],
          ),
        ),

        h16,

        // # Product Information
        AppPagePadding(
          child: AppSkeleton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // # Product Name
                const Bone.text(width: double.infinity, fontSize: 17),

                h4,

                const Bone.text(width: 200, fontSize: 17),

                h8,

                // # Part Number
                const Bone.text(width: 95, fontSize: 12),

                h12,

                // # Description
                const Bone.text(width: double.infinity, fontSize: 13),

                h4,

                const Bone.text(width: 240, fontSize: 13),

                h12,

                // # Product Price
                const Bone.text(width: 65, fontSize: 17),

                h12,

                Divider(color: AppColors.border),

                h8,

                // # Quality
                const Row(
                  children: [
                    Bone.text(width: 42, fontSize: 12),
                    SizedBox(width: 6),
                    Bone.text(width: 55, fontSize: 12),
                  ],
                ),

                h4,

                // # Compatibility
                const Row(
                  children: [
                    Bone.text(width: 65, fontSize: 12),
                    SizedBox(width: 6),
                    Expanded(
                      child: Bone.text(width: double.infinity, fontSize: 12),
                    ),
                  ],
                ),

                h8,

                Divider(color: AppColors.border),
              ],
            ),
          ),
        ),

        h16,
      ],
    );
  }
}
