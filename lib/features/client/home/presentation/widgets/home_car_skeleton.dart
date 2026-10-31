
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCarSkeleton extends StatelessWidget {
  const HomeCarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            // # Car Image
            const Bone.circle(size: 64),

            h4,

            // # Car Name
            const Bone.text(
              width: 58,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCarsSkeleton extends StatelessWidget {
  const HomeCarsSkeleton({
    super.key,
    this.carCount = 3,
  });

  final int carCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: List.generate(
              carCount,
              (index) => Padding(
                padding: EdgeInsetsDirectional.only(
                  end: index == carCount - 1 ? 0 : 12,
                ),
                child: const HomeCarSkeleton(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
