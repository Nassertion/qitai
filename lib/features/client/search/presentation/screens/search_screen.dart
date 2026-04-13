import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/classification/presentation/widgets/classification_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/search_widget.dart';

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
          children: [Padding12, SearchWidget(), ClassificationWidget()],
        ),
      ),
    );
  }
}
