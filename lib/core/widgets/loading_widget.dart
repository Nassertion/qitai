import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qitai/core/constants/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.primaryButton,
        size: 24,
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CategoriesLoadingWidget extends StatelessWidget {
//   const CategoriesLoadingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 95,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: 4,
//         separatorBuilder: (_, __) => w12,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               const SizedBox(
//                 width: 74,
//                 height: 56,
//                 child: Center(
//                   child: SizedBox(
//                     width: 36,
//                     height: 36,
//                     child: CircularProgressIndicator(strokeWidth: 4),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 width: 50,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
