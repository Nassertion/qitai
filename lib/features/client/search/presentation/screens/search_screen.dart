import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/classification/presentation/widgets/classification_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/search_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_card_product_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/suggestion_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "البحث",
        action: Container(
          padding: EdgeInsets.all(16),
          child: SvgPicture.asset("assets/icons/shopping-cart.svg"),
        ),
      ),
      body: AppPagePadding(
        child: Column(
          spacing: 0,
          children: [
            Padding12,
            SearchWidget(),
            ClassificationWidget(),
            // Column(
            //   spacing: 8,
            //   children: [
            //     SearchCardProductWidget(),
            //     SearchCardProductWidget(),
            //     SearchCardProductWidget(),
            //     SearchCardProductWidget(),
            //   ],
            // ),
            // EmptyDataWidget(
            //   text: "لاتوجد نتائج في البحث!",
            //   img: "assets/icons/Object.svg",
            // ),
          ],
        ),
      ),
    );
  }
}
