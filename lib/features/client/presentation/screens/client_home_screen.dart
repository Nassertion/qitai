import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/app_bar.dart';
import 'package:qitai/features/client/presentation/widgets/card_product.dart';
import 'package:qitai/features/client/presentation/widgets/header.dart';
import 'package:qitai/features/client/presentation/widgets/search.dart';
import 'package:qitai/features/client/presentation/widgets/slider_widget.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(),
      body: AppPagePadding(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding8, search(),
            dPadding,
            sectionHeader("سياراتي"),
            Padding12,
            //temp
            Row(children: [addCar("assets/icons/addCar.svg", "اضف سيارتك")]),
            dPadding,
            //temp
            ClientBannerSlider(),
            SizedBox(height: 24),
            sectionHeader("الفئات"),
            Padding12,
            //temp
            //خله يطلع من البادنق
            SizedBox(
              height: 95,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => Column(
                  children: [
                    Image.asset(
                      'assets/images/framl.png',
                      width: 74,
                      height: 56,
                    ),
                    Padding8,
                    Text(
                      "الفرامل",
                      style: AppTextStyles.mediumOverline.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dPadding,
            sectionHeader("مناسب لسيارتي"),
            Padding12,
            GridView.builder(
              itemCount: 8,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                // childAspectRatio: 1,
                mainAxisExtent: 237, // This sets the fixed height
              ),
              itemBuilder: (context, index) => ProductCard(),
            ),
          ],
        ),
      ),
    );
  }

  //if no car -> default
  //temp
  Column addCar(String img, String carName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          width: 64,
          child: CircleAvatar(
            backgroundColor: AppColors.backgroudColor,
            child: SvgPicture.asset(img),
          ),
        ),
        Padding4,
        Text(
          carName,
          style: AppTextStyles.mediumOverline.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
