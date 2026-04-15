import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/search_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    return Scaffold(
      // bottomNavigationBar: BottomFloatingNavBar(),
      appBar: HomeAppBarWidget(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppPagePadding(
            child: Column(
              children: [
                Padding8,
                SearchWidget(
                  readOnly: true,
                  onTap: () => context.push("/search"),
                ),
                dPadding,
                SectionHeader(
                  title: "سياراتي",
                  // onTap: () => context.push("/search"),
                ),
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
              ],
            ),
          ),
          //temp
          ClientBannerSlider(),
          SizedBox(height: 24),
          AppPagePadding(
            child: SectionHeader(
              title: "الفئات",
              onTap: () => (context.push("/categories")),
            ),
          ),
          Padding12,
          //temp
          SizedBox(
            height: 95,
            child: categoriesAsync.when(
              loading: () => CustomLoading(),
              error: (error, stack) => Center(
                child: Text(
                  error.toString(),
                  style: AppTextStyles.regularOverline.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              data: (categories) => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Column(
                    children: [
                      Image.asset(
                        getCategoryIcon(category.name),
                        width: 74,
                        height: 56,
                      ),
                      Padding8,
                      Text(
                        category.name,
                        style: AppTextStyles.mediumOverline.copyWith(
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          dPadding,
          // if no sign in
          AppPagePadding(
            child: Column(
              children: [
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
          ),
        ],
      ),
    );
  }
}
