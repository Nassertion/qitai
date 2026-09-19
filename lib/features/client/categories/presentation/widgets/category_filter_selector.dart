import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_product_notifier.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';

class CategoryFilterSelector extends ConsumerStatefulWidget {
  const CategoryFilterSelector({super.key, required this.categoryId});

  final int categoryId;

  @override
  ConsumerState<CategoryFilterSelector> createState() =>
      _CategoryFilterSelectorState();
}

class _CategoryFilterSelectorState
    extends ConsumerState<CategoryFilterSelector> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(vehicleProvider.notifier).loadBrands();
    });
  }

  void _showBrandFilter(
    BuildContext context,
    VehicleState state,
    VehicleNotifier notifier,
  ) {
    if (state.carBrands.isEmpty) return;

    VehicleFilterBottomSheet.show<CarBrand>(
      context: context,
      items: state.carBrands,
      title: 'اختر نوع البراند',
      getLabel: (item) => item.name,
      onSelected: (value) async {
        await notifier.selectBrand(value);
      },
    );
  }

  void _showModelFilter(
    BuildContext context,
    VehicleState state,
    VehicleNotifier notifier,
  ) {
    if (state.selectedCarBrand == null) return;
    if (state.isModelsLoading) return;

    VehicleFilterBottomSheet.show<CarModel>(
      context: context,
      items: state.models,
      title: 'اختر الموديل',
      getLabel: (item) => item.name,
      onRetry: () async {
        await notifier.selectBrand(state.selectedCarBrand!);
      },
      onSelected: (value) async {
        await notifier.selectModel(value);
      },
    );
  }

  void _showYearFilter(
    BuildContext context,
    VehicleState state,
    VehicleNotifier notifier,
  ) {
    if (state.selectedModel == null) return;
    if (state.isYearsLoading) return;

    VehicleFilterBottomSheet.show<CarYear>(
      context: context,
      items: state.carYears,
      title: 'اختر السنة',
      getLabel: (item) => item.year.toString(),
      onRetry: () async {
        await notifier.selectModel(state.selectedModel!);
      },
      onSelected: (value) {
        notifier.selectCarYear(value);
      },
    );
  }

  void _showSectionFilter(
    BuildContext context,
    List<Category> children,
    CategoryProductNotifier notifier,
  ) {
    if (children.isEmpty) return;

    VehicleFilterBottomSheet.show<Category>(
      context: context,
      items: children,
      title: 'اختر القسم',
      getLabel: (item) => item.name,
      onSelected: (value) async {
        await notifier.selectSection(value.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vehicleState = ref.watch(vehicleProvider);
    final vehicleNotifier = ref.read(vehicleProvider.notifier);

    final categoryState = ref.watch(categoryProductProvider(widget.categoryId));

    final categoryNotifier = ref.read(
      categoryProductProvider(widget.categoryId).notifier,
    );

    final categoryTreeAsync = ref.watch(categoryTreeProvider);

    final parentCategory = categoryTreeAsync.maybeWhen(
      data: (categories) {
        for (final item in categories) {
          if (item.category.id == widget.categoryId) {
            return item;
          }
        }

        return null;
      },
      orElse: () => null,
    );

    final children = parentCategory?.children ?? const <Category>[];

    final selectedSection = children.where(
      (item) => item.id == categoryState.selectedCategoryId,
    );

    final isSectionSelected =
        categoryState.selectedCategoryId != widget.categoryId &&
        selectedSection.isNotEmpty;

    final hasSelectedFilters =
        vehicleState.selectedCarBrand != null ||
        vehicleState.selectedModel != null ||
        vehicleState.selectedCarYear != null ||
        isSectionSelected;

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 8.0;
          const horizontalPadding = 16.0;

          final baseItemWidth =
              (constraints.maxWidth - (spacing * 3) - (horizontalPadding * 2)) /
              4;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: baseItemWidth,
                      child: _CategoryFilterField(
                        title: 'البراند',
                        onTap: () {
                          _showBrandFilter(
                            context,
                            vehicleState,
                            vehicleNotifier,
                          );
                        },
                        isSelectedStyle: false,
                      ),
                    ),

                    const SizedBox(width: spacing),

                    SizedBox(
                      width: baseItemWidth,
                      child: _CategoryFilterField(
                        title: 'الموديل',
                        onTap: () {
                          _showModelFilter(
                            context,
                            vehicleState,
                            vehicleNotifier,
                          );
                        },
                        isSelectedStyle: false,
                      ),
                    ),

                    const SizedBox(width: spacing),

                    SizedBox(
                      width: baseItemWidth,
                      child: _CategoryFilterField(
                        title: 'السنة',
                        onTap: () {
                          _showYearFilter(
                            context,
                            vehicleState,
                            vehicleNotifier,
                          );
                        },
                        isSelectedStyle: false,
                      ),
                    ),

                    const SizedBox(width: spacing),

                    SizedBox(
                      width: baseItemWidth,
                      child: _CategoryFilterField(
                        title: 'القسم',
                        onTap: () {
                          _showSectionFilter(
                            context,
                            children,
                            categoryNotifier,
                          );
                        },
                        isSelectedStyle: false,
                      ),
                    ),
                  ],
                ),
              ),

              if (hasSelectedFilters) ...[
                const SizedBox(height: 8),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSelectedField(
                          baseWidth: baseItemWidth,
                          selectedTitle: vehicleState.selectedCarBrand?.name,
                          onDelete: vehicleNotifier.clearBrand,
                        ),

                        const SizedBox(width: spacing),

                        _buildSelectedField(
                          baseWidth: baseItemWidth,
                          selectedTitle: vehicleState.selectedModel?.name,
                          onDelete: vehicleNotifier.clearModel,
                        ),

                        const SizedBox(width: spacing),

                        _buildSelectedField(
                          baseWidth: baseItemWidth,
                          selectedTitle: vehicleState.selectedCarYear?.year
                              .toString(),
                          onDelete: vehicleNotifier.clearYear,
                        ),

                        const SizedBox(width: spacing),

                        _buildSelectedField(
                          baseWidth: baseItemWidth,
                          selectedTitle: isSectionSelected
                              ? selectedSection.first.name
                              : null,
                          onDelete: categoryNotifier.clearSection,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSelectedField({
    required double baseWidth,
    required String? selectedTitle,
    required VoidCallback onDelete,
  }) {
    if (selectedTitle == null) {
      return SizedBox(width: baseWidth, height: 35);
    }

    final selectedWidth = _calculateSelectedWidth(
      title: selectedTitle,
      baseWidth: baseWidth,
    );

    return SizedBox(
      width: selectedWidth,
      child: _CategoryFilterField(
        title: selectedTitle,
        isSelectedStyle: true,
        onDelete: onDelete,
      ),
    );
  }

  double _calculateSelectedWidth({
    required String title,
    required double baseWidth,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: AppTextStyles.mediumCaption.copyWith(
          color: AppColors.actionText,
          height: 1.2,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.rtl,
    )..layout();

    const horizontalPadding = 12.0;
    const iconWidth = 22.0;
    const spacing = 2.0;

    final requiredWidth =
        textPainter.width + horizontalPadding + iconWidth + spacing;

    return requiredWidth > baseWidth ? requiredWidth : baseWidth;
  }
}

class _CategoryFilterField extends StatelessWidget {
  const _CategoryFilterField({
    required this.title,
    this.onTap,
    required this.isSelectedStyle,
    this.onDelete,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isSelectedStyle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSelectedStyle ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelectedStyle ? AppColors.actionText : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.inputFieldAndCards,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  softWrap: false,
                  overflow: isSelectedStyle
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: isSelectedStyle
                      ? AppTextStyles.mediumCaption.copyWith(
                          color: AppColors.actionText,
                          height: 1.2,
                        )
                      : AppTextStyles.regularOverline.copyWith(
                          color: AppColors.secondaryText,
                        ),
                ),
              ),

              const SizedBox(width: 2),

              if (isSelectedStyle)
                InkWell(
                  onTap: onDelete,
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      "assets/icons/close-circle.svg",
                      height: 14,
                      width: 14,
                    ),
                  ),
                )
              else
                SvgPicture.asset(
                  "assets/icons/arrow-down.svg",
                  height: 14,
                  width: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
