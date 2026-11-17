
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/cart/presentation/providers/cart_notifier.dart';
import 'package:qitai/features/client/cart/presentation/widgets/cart_item_widget.dart';
import 'package:qitai/features/client/cart/presentation/widgets/cart_success_notice.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final Set<int> _updatingProducts = {};

  Future<void> _changeQuantity({
    required int productId,
    required bool increment,
  }) async {
    if (_updatingProducts.contains(productId)) return;

    setState(() {
      _updatingProducts.add(productId);
    });

    try {
      final notifier = ref.read(cartProvider.notifier);

      if (increment) {
        await notifier.incrementQuantity(productId);
      } else {
        await notifier.decrementQuantity(productId);
      }
    } catch (_) {
      if (!mounted) return;

      _showError('تعذر تحديث الكمية، حاول مرة أخرى');
    } finally {
      if (mounted) {
        setState(() {
          _updatingProducts.remove(productId);
        });
      }
    }
  }

  Future<bool> _confirmDelete() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.inputFieldAndCards,
          surfaceTintColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SizedBox(
            width: 270,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Text(
                  'حذف المنتج',
                  style: AppTextStyles.boldBody.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    'سوف يتم حذف المنتج من سلتك، هل تود المتابعة؟',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regularOverline
                        .copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.border,
                ),
                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext, true),
                          child: Text(
                            'حذف',
                            style: AppTextStyles.semiBoldBody
                                .copyWith(
                              color: AppColors.errorText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: AppColors.border,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext, false),
                          child: Text(
                            'تراجع',
                            style: AppTextStyles.regularBody
                                .copyWith(
                              color: AppColors.actionText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result ?? false;
  }

  Future<void> _deleteItem(int productId) async {
    if (_updatingProducts.contains(productId)) return;

    final confirmed = await _confirmDelete();

    if (!mounted || !confirmed) return;

    setState(() {
      _updatingProducts.add(productId);
    });

    try {
      await ref.read(cartProvider.notifier).removeItem(productId);

      if (!mounted) return;

      CartSuccessNotice.show(
        context,
        message: 'تمت إزالة العنصر من السلة بنجاح.',
      );
    } catch (_) {
      if (!mounted) return;

      _showError('تعذر حذف المنتج، حاول مرة أخرى');
    } finally {
      if (mounted) {
        setState(() {
          _updatingProducts.remove(productId);
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  int _calculateSubtotal(List<LocalCartItem> items) {
    return items.fold<int>(
      0,
      (total, item) =>
          total + item.unitPrice * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        title: 'سلتي',
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/search-normal.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      body: cartAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (_, _) => const Center(
          child: Text('تعذر تحميل السلة، حاول مرة أخرى'),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const AppPagePadding(
              child: EmptyDataWidget(
                img: 'assets/icons/cart.svg',
                text: 'لاتوجد منتجات في السلة!',
                buttonText: 'اضافة للسلة',
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final productId = item.productId;

                    return CartItemWidget(
                      key: ValueKey(productId),
                      item: item,
                      isUpdating: _updatingProducts
                          .contains(productId),
                      onIncrement: () {
                        _changeQuantity(
                          productId: productId,
                          increment: true,
                        );
                      },
                      onDecrement: () {
                        _changeQuantity(
                          productId: productId,
                          increment: false,
                        );
                      },
                      onDelete: () => _deleteItem(productId),
                    );
                  },
                ),
              ),
              _CartSubtotalBar(
                subtotal: _calculateSubtotal(items),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartSubtotalBar extends StatelessWidget {
  const _CartSubtotalBar({
    required this.subtotal,
  });

  final int subtotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'الإجمالي:',
                style: AppTextStyles.boldBody.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$subtotal',
                style: AppTextStyles.boldBody.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: 2),
              SvgPicture.asset(
                'assets/icons/SR.svg',
                width: 16,
                height: 16,
              ),
            ],
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 165,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primaryButton,
                    disabledBackgroundColor:
                        AppColors.primaryButton,
                    disabledForegroundColor:
                        AppColors.whiteText,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'اذهب للدفع',
                    style: AppTextStyles.boldBody.copyWith(
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
