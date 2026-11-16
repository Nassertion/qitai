
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/cart/presentation/providers/cart_notifier.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/presentation/widgets/quantity_widget.dart';

class AddToCartSection extends ConsumerStatefulWidget {
  const AddToCartSection({
    super.key,
    required this.product,
  });

  final ProductDetail product;

  @override
  ConsumerState<AddToCartSection> createState() =>
      _AddToCartSectionState();
}

class _AddToCartSectionState
    extends ConsumerState<AddToCartSection> {
  int quantity = 1;
  bool isAdding = false;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity <= 1) return;

    setState(() {
      quantity--;
    });
  }

  Future<void> openQuantityDialog() async {
    final result = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: QuantityWidget(initialQuantity: quantity),
      ),
    );

    if (!mounted) return;

    if (result != null && result > 0) {
      setState(() {
        quantity = result;
      });
    }
  }

  String? getPrimaryImageUrl() {
    final images = widget.product.images;

    if (images.isEmpty) return null;

    for (final image in images) {
      if (image.isPrimary) {
        return image.url;
      }
    }

    return images.first.url;
  }

  Future<void> addToCart() async {
    if (isAdding) return;

    setState(() {
      isAdding = true;
    });

    final product = widget.product;

    final item = LocalCartItem(
      productId: product.id,
      quantity: quantity,
      name: product.name,
      sku: product.sku,
      partNumber: product.partNumber,
      quality: product.quality,
      unitPrice: product.price,
      imageUrl: getPrimaryImageUrl(),
    );

    try {
      await ref.read(cartProvider.notifier).addItem(item);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تمت إضافة المنتج إلى السلة'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذرت إضافة المنتج للسلة، حاول مرة أخرى'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isAdding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
        color: AppColors.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppPagePadding(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                color: AppColors.inputFieldAndCards,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: isAdding ? null : decreaseQuantity,
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Center(
                        child: Icon(Icons.remove, size: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: isAdding ? null : openQuantityDialog,
                    child: SizedBox(
                      width: 36,
                      height: 32,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.mediumOverline.copyWith(
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: isAdding ? null : increaseQuantity,
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Center(
                        child: Icon(Icons.add, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            w12,
            Expanded(
              child: ButtonWidget(
                text: isAdding ? 'جارٍ الإضافة...' : 'أضف للسلة',
                enabled: !isAdding,
                onPressed: () {
                  addToCart();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
