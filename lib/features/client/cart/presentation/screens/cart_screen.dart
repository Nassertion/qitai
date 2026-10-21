import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/confirmation_dialog.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/products/presentation/widgets/product_quality_badge.dart';

// ================================================================
// # 01 - FIGMA DIMENSIONS
// الألوان والخط من ملفات المشروع. هنا فقط القياسات الخاصة بواجهة السلة.
// ================================================================
abstract class _CartSizes {
  static const double tileHeight = 122;
  static const double imageSize = 90;
  static const double imageRadius = 8;
  static const double quantitySize = 32;
  static const double checkoutHeight = 66;
  static const double shellNavClearance = 94;
}

// ================================================================
// # 02 - MOCK DATA (UI PREVIEW ONLY)
// لاحقًا نستبدلها ببيانات CartNotifier.
// ================================================================
class _CartPreviewItem {
  const _CartPreviewItem({
    required this.id,
    required this.name,
    required this.partNumber,
    required this.quality,
    required this.unitPrice,
    required this.quantity,
    this.imageAsset,
  });

  final int id;
  final String name;
  final String partNumber;
  final String quality;
  final int unitPrice;
  final int quantity;
  final String? imageAsset;

  _CartPreviewItem withQuantity(int value) => _CartPreviewItem(
    id: id,
    name: name,
    partNumber: partNumber,
    quality: quality,
    unitPrice: unitPrice,
    quantity: value,
    imageAsset: imageAsset,
  );
}

// ================================================================
// # 03 - CART SCREEN
// showEmpty: true لعرض حالة السلة الفارغة أثناء مراجعة Figma.
// لا نضيف BottomNavigationBar لأن MainShellScreen يعرضه مسبقًا.
// ================================================================
class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    this.showEmpty = false,
    this.onBrowseProducts,
    this.onCheckout,
  });

  final bool showEmpty;
  final VoidCallback? onBrowseProducts;
  final VoidCallback? onCheckout;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<_CartPreviewItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.showEmpty
        ? []
        : [
            const _CartPreviewItem(
              id: 1,
              name: 'فحمات فرامل أمامية - كامري 2026',
              partNumber: '06150-04465',
              quality: 'oem',
              unitPrice: 300,
              quantity: 1,
            ),
            const _CartPreviewItem(
              id: 2,
              name: 'فحمات فرامل أمامية - كامري 2026',
              partNumber: '07750-24995',
              quality: 'aftermarket',
              unitPrice: 150,
              quantity: 1,
            ),
            const _CartPreviewItem(
              id: 3,
              name: 'فحمات فرامل خلفية - كامري 2026',
              partNumber: '01123-00486',
              quality: 'aftermarket',
              unitPrice: 150,
              quantity: 1,
            ),
          ];
  }

  // # 03.1 - DEMO STATE (NOT PERSISTED)
  int get _subtotal => _items.fold<int>(
    0,
    (total, item) => total + item.unitPrice * item.quantity,
  );

  void _changeQuantity(int id, int difference) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final quantity = _items[index].quantity + difference;
    if (quantity < 1) return;
    setState(() => _items[index] = _items[index].withQuantity(quantity));
  }

  // # 03.2 - DELETE CONFIRMATION
  Future<bool> _deleteItem(_CartPreviewItem item) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'حذف المنتج',
      message: 'سوف يتم حذف المنتج من سلتك، هل تود المتابعة؟',
      confirmText: 'حذف',
    );
    if (!mounted || confirmed != true) return false;
    setState(() => _items.removeWhere((value) => value.id == item.id));
    _showCartMessage('تم حذف المنتج من السلة بنجاح');
    return true;
  }

  // # 03.3 - NOTIFICATION (TEMPORARY)
  void _showCartMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.noInternet,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppColors.successText,
              size: 18,
            ),
            w8,
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.regularOverline.copyWith(
                  color: AppColors.whiteText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          // # 04 - HEADER
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'سلتي',
            style: AppTextStyles.boldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'بحث',
              onPressed: () => context.push('/search'),
              icon: const Icon(Icons.search, color: AppColors.primaryText),
            ),
            w8,
          ],
        ),
        // # 05 - BODY + FOOTER
        body: _items.isEmpty
            ? _EmptyCartView(
                bottomClearance: _CartSizes.shellNavClearance,
                onBrowseProducts:
                    widget.onBrowseProducts ?? () => context.go('/'),
              )
            : Stack(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom:
                          _CartSizes.checkoutHeight +
                          _CartSizes.shellNavClearance +
                          20,
                    ),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _CartProductTile(
                        key: ValueKey(item.id),
                        item: item,
                        onIncrement: () => _changeQuantity(item.id, 1),
                        onDecrement: () => _changeQuantity(item.id, -1),
                        onDelete: () => _deleteItem(item),
                      );
                    },
                  ),
                  Positioned(
                    bottom: _CartSizes.shellNavClearance,
                    right: 0,
                    left: 0,
                    child: _CartCheckoutFooter(
                      subtotal: _subtotal,
                      onCheckout:
                          widget.onCheckout ??
                          () => _showCartMessage('الدفع غير مربوط بعد'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ================================================================
// # 06 - PRODUCT TILE
// Figma: صورة المنتج يمين، الاسم والرقم وسط، الحذف يسار.
// سطر مستقل للكمية والسعر أسفل التفاصيل.
// ================================================================
class _CartProductTile extends StatelessWidget {
  const _CartProductTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  final _CartPreviewItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Future<bool> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _CartSizes.tileHeight,
      child: AppPagePadding(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // # 06.1 - PRODUCT IMAGE
              _CartProductImage(
                imageAsset: item.imageAsset,
                quality: item.quality,
              ),
              w12,
              // # 06.2 - PRODUCT DETAILS + ACTIONS
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.boldOverline.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                              h4,
                              Text(
                                'رقم القطعة: ${item.partNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.regularOverline.copyWith(
                                  color: AppColors.disabledText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        w8,
                        // # 06.3 - DELETE ICON
                        SizedBox(
                          width: 26,
                          height: 28,
                          child: IconButton(
                            tooltip: 'حذف المنتج',
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              onDelete();
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // # 06.4 - PRICE
                        Expanded(
                          child: Text(
                            '${item.unitPrice} ﷼',
                            style: AppTextStyles.boldCaption.copyWith(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        // # 06.5 - QUANTITY CONTROLS (RTL: - , count , +)
                        _CartQuantityButton(
                          add: false,
                          enabled: item.quantity > 1,
                          onTap: onDecrement,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${item.quantity}',
                            style: AppTextStyles.boldCaption.copyWith(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        _CartQuantityButton(add: true, onTap: onIncrement),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// # 07 - PRODUCT IMAGE
// ضع مسار الصورة في mock item.imageAsset لاحقًا.
// إذا لم تتوفر صورة نعرض مساحة محايدة بدل صورة غير مطابقة.
// ================================================================
class _CartProductImage extends StatelessWidget {
  const _CartProductImage({required this.imageAsset, required this.quality});

  final String? imageAsset;
  final String quality;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _CartSizes.imageSize,
      height: _CartSizes.imageSize,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.image,
        borderRadius: BorderRadius.circular(_CartSizes.imageRadius),
      ),
      child: Stack(
        children: [
          if (imageAsset != null)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  imageAsset!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
          Positioned(
            top: 4,
            right: 4,
            child: ProductQualityBadge(quality: quality, compact: true),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// # 08 - QUANTITY BUTTON
// ================================================================
class _CartQuantityButton extends StatelessWidget {
  const _CartQuantityButton({
    required this.add,
    required this.onTap,
    this.enabled = true,
  });

  final bool add;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CartSizes.quantitySize,
      height: _CartSizes.quantitySize,
      child: Material(
        color: add ? AppColors.primaryButton : AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(9),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: add ? null : Border.all(color: AppColors.errorText),
            ),
            child: Icon(
              add ? Icons.add : Icons.remove,
              size: 20,
              color: add ? AppColors.whiteText : AppColors.errorText,
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// # 09 - CHECKOUT FOOTER
// MainShellScreen يعرض النافبار؛ نترك له مساحة أسفل الشاشة.
// ================================================================
class _CartCheckoutFooter extends StatelessWidget {
  const _CartCheckoutFooter({required this.subtotal, required this.onCheckout});

  final int subtotal;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _CartSizes.checkoutHeight,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: AppPagePadding(
        child: Row(
          children: [
            Expanded(
              child: Text(
                'الإجمالي: $subtotal ﷼',
                style: AppTextStyles.boldCaption.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
            ),
            SizedBox(
              width: 156,
              child: ButtonWidget(
                text: 'اذهب للدفع',
                height: 48,
                onPressed: onCheckout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// # 10 - EMPTY CART
// لاحقًا نضع صورة Figma الأصلية بدل الأيقونة المؤقتة.
// ================================================================
class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView({
    required this.onBrowseProducts,
    required this.bottomClearance,
  });

  final VoidCallback onBrowseProducts;
  final double bottomClearance;

  @override
  Widget build(BuildContext context) {
    return AppPagePadding(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomClearance),
        child: Column(
          children: [
            const Spacer(flex: 3),
            // # 10.1 - EMPTY ILLUSTRATION ASSET SLOT
            const Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: AppColors.disabledText,
            ),
            h12,
            Text(
              'لا توجد منتجات في السلة!',
              textAlign: TextAlign.center,
              style: AppTextStyles.boldCaption.copyWith(
                color: AppColors.primaryText,
              ),
            ),
            const Spacer(flex: 2),
            // # 10.2 - BROWSE BUTTON
            ButtonWidget(
              text: 'إضافة للسلة',
              height: 48,
              onPressed: onBrowseProducts,
            ),
            h16,
          ],
        ),
      ),
    );
  }
}
