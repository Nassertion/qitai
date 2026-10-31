
import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCarSkeleton extends StatelessWidget {
  const HomeCarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFE8EAED),
        highlightColor: Color(0xFFF8F9FA),
        duration: Duration(milliseconds: 1200),
      ),
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
    this.count = 3,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            // # Match Real Cars Spacing
            padding: const EdgeInsetsDirectional.only(
              start: 16,
              end: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: List.generate(
                count,
                (index) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: index == count - 1 ? 0 : 12,
                  ),
                  child: const HomeCarSkeleton(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
