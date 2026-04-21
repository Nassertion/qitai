import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/section_header_widget.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/slider_widget.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      // bottomNavigationBar: BottomFloatingNavBar(),
      appBar: HomeAppBarWidget(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
                  onTap: () => context.push("/test"),
                ),
                Padding12,
                Row(
                  children: [
                    AddCar(
                      img: "assets/icons/addCar.svg",
                      carName: "اضف سيارتك",
                    ),
                  ],
                ),
                dPadding,
                ClientBannerSlider(),
                const SizedBox(height: 24),
                SectionHeader(
                  title: "الفئات",
                  onTap: () => context.push("/categories"),
                ),
                Padding12,
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                dPadding,
                SectionHeader(title: "اقتراحات", onTap: () => print("test")),
                Padding12,
              ],
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(),
                childCount: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 260,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
