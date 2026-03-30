import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/floating_nav_bar_widget.dart';
import 'package:qitai/features/client/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/presentation/widgets/card_product_widget.dart';
import 'package:qitai/features/client/presentation/widgets/section_header_widget.dart';
import 'package:qitai/features/client/presentation/widgets/search_widget.dart';
import 'package:qitai/features/client/presentation/widgets/slider_widget.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomFloatingNavBar(),
      appBar: CustomAppbar(),
      body: AppPagePadding(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding8, SearchWidget(),
                dPadding,
                SectionHeader(title: "سياراتي", onTap: () => print("test")),
                Padding12,
                //temp
                Row(
                  children: [
                    AddCar(
                      img: "assets/icons/addCar.svg",
                      carName: "اضف سيارتك",
                    ),
                  ],
                ),
                dPadding,
                //temp
                ClientBannerSlider(),
                SizedBox(height: 24),
                SectionHeader(title: "الفئات", onTap: () => print("test")),
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
                // if no sign in
                SectionHeader(title: "اقتراحات", onTap: () => print("test")),
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
                    mainAxisExtent: 237,
                  ),
                  itemBuilder: (context, index) => ProductCard(),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: CustomFloatingNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
