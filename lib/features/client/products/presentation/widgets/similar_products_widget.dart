import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/presentation/provider/similar_products_provider.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';

class SimilarProductsWidget extends ConsumerWidget {
  final int productId;

  const SimilarProductsWidget({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarProductsAsync = ref.watch(
      similarProductsProvider(productId),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPagePadding(
          child: Text(
            'منتجات مشابهة',
            style: AppTextStyles.boldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ),
        h12,
        similarProductsAsync.when(
          loading: () => const SizedBox(
            height: 260,
            child: Center(
              child: CustomLoading(),
            ),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(error.toString()),
          ),
          data: (products) {
            if (products.isEmpty) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              height: 260,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, _) => w16,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return SizedBox(
                    width: 160,
                    child: AllProductCardWidget(
                      product: product,
                      onTap: () {
                        context.push('/product/${product.id}');
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}