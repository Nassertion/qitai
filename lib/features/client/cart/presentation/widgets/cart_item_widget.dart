
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_quality_badge.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    this.isUpdating = false,
  });

  final LocalCartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Future<void> Function() onDelete;
  final bool isUpdating;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  static const double _revealWidth = 64;
  static const double _swipeThreshold = 28;

  bool _isRevealed = false;
  double _dragDistance = 0;

  void _openDelete() {
    if (widget.isUpdating) return;

    setState(() {
      _isRevealed = true;
    });
  }

  void _closeDelete() {
    if (!_isRevealed) return;

    setState(() {
      _isRevealed = false;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.isUpdating) return;

    _dragDistance += details.delta.dx;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.isUpdating) {
      _dragDistance = 0;
      return;
    }

    final velocity = details.primaryVelocity ?? 0;

    if (_dragDistance > _swipeThreshold || velocity > 500) {
      _openDelete();
    } else if (_dragDistance < -_swipeThreshold ||
        velocity < -500) {
      _closeDelete();
    }

    _dragDistance = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 123,
      child: ClipRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _revealWidth,
                  color: AppColors.image,
                  alignment: Alignment.center,
                  child: Material(
                    color: AppColors.errorText.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      key: const ValueKey('cart-confirm-delete'),
                      onTap: widget.isUpdating
                          ? null
                          : () async {
                              await widget.onDelete();

                              if (mounted) {
                                _closeDelete();
                              }
                            },
                      borderRadius: BorderRadius.circular(12),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.delete_outline,
                          color: AppColors.errorText,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(
                _isRevealed ? _revealWidth : 0,
                0,
                0,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                child: Container(
                  width: double.infinity,
                  color: AppColors.backgroundColor,
                  padding: const EdgeInsets.all(16),
                  child: _CartItemContent(
                    item: widget.item,
                    isUpdating: widget.isUpdating,
                    onIncrement: widget.onIncrement,
                    onDecrement: widget.onDecrement,
                    onRevealDelete: _openDelete,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemContent extends StatelessWidget {
  const _CartItemContent({
    required this.item,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRevealDelete,
  });

  final LocalCartItem item;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRevealDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ProductImage(
          imageUrl: item.imageUrl,
          quality: item.quality,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 91,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: AppTextStyles.semiBoldOverline
                                .copyWith(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: onRevealDelete,
                          child: const SizedBox(
                            width: 16,
                            height: 20,
                            child: Icon(
                              Icons.delete_outline,
                              size: 16,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'رقم القطعة: ${item.partNumber}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.regularOverline
                            .copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    _ItemPrice(price: item.unitPrice),
                    _QuantityControls(
                      quantity: item.quantity,
                      isUpdating: isUpdating,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.imageUrl,
    required this.quality,
  });

  final String? imageUrl;
  final String quality;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 91,
      height: 91,
      child: Stack(
        children: [
          Container(
            width: 91,
            height: 91,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.image,
              borderRadius: BorderRadius.circular(8),
            ),
            child: imageUrl == null || imageUrl!.isEmpty
                ? const Icon(
                    Icons.image_outlined,
                    color: AppColors.secondaryText,
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) =>
                        const Icon(
                      Icons.broken_image_outlined,
                      color: AppColors.secondaryText,
                    ),
                  ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: ProductQualityBadge(
              quality: quality,
              compact: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemPrice extends StatelessWidget {
  const _ItemPrice({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$price',
          style: AppTextStyles.semiBoldCaption.copyWith(
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
    );
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({
    required this.quantity,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(
          increment: false,
          onPressed: isUpdating || quantity <= 1
              ? null
              : onDecrement,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 24,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBoldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ),
        const SizedBox(width: 8),
        _QuantityButton(
          increment: true,
          onPressed: isUpdating ? null : onIncrement,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.increment,
    required this.onPressed,
  });

  final bool increment;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    return Material(
      color: disabled
          ? AppColors.border
          : increment
              ? AppColors.primaryButton
              : AppColors.errorText.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !disabled && !increment
                ? Border.all(color: AppColors.errorText)
                : null,
          ),
          child: Icon(
            increment ? Icons.add : Icons.remove,
            size: 20,
            color: disabled
                ? AppColors.secondaryText
                : increment
                    ? AppColors.whiteText
                    : AppColors.errorText,
          ),
        ),
      ),
    );
  }
}
