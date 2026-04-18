import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/features/client/search/data/model/search_suggestion_model.dart';

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({
    super.key,
    required this.suggestions,
    this.onTapSuggestion,
  });

  final List<SearchSuggestionModel> suggestions;
  final ValueChanged<SearchSuggestionModel>? onTapSuggestion;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: suggestions.length,
      // separatorBuilder: (_, __) => Divider(color: AppColors.border, height: 1),
      itemBuilder: (context, index) {
        final item = suggestions[index];

        return InkWell(
          onTap: () => onTapSuggestion?.call(item),
          child: Column(
            children: [
              dPadding,
              Row(
                children: [
                  dPadding,
                  Image.asset(
                    "assets/images/search/test.png",
                    height: 44,
                    width: 44,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.name,
                    style: AppTextStyles.mediumOverline.copyWith(
                      color: AppColors.primaryText,
                      height: 1,
                    ),
                  ),
                ],
              ),
              dPadding,
              Divider(color: AppColors.border, height: 1),
            ],
          ),
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:qitai/core/constant/colors.dart';
// import 'package:qitai/core/constant/spaces.dart';
// import 'package:qitai/core/constant/text_styles.dart';

// class SuggestionWidget extends StatelessWidget {
//   const SuggestionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       // padding: EdgeInsets.symmetric(vertical: 16),
//       children: [
//         InkWell(
//           onTap: () => print("test"),
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //               Image.asset(
    //                 "assets/images/search/test.png",
    //                 height: 44,
    //                 width: 44,
    //               ),
    //               const SizedBox(width: 12),
    //               Text(
    //                 "فحمات",
    //                 style: AppTextStyles.mediumOverline.copyWith(
    //                   color: AppColors.primaryText,
    //                   height: 1,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           dPadding,
    //           Divider(color: AppColors.border, height: 1),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
//   }
// }