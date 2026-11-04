
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_attribute.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/user/cars/presentation/widgets/car_attribute_bottom_sheet.dart';
import 'package:qitai/features/client/user/cars/presentation/widgets/car_status_dialog.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicles_widget.dart';

// # Add Car Screen
class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        vehicleProvider.overrideWith(VehicleNotifier.new),
      ],
      child: const _AddCarContent(),
    );
  }
}

// # Add Car Content
class _AddCarContent extends ConsumerStatefulWidget {
  const _AddCarContent();

  @override
  ConsumerState<_AddCarContent> createState() =>
      _AddCarContentState();
}

class _AddCarContentState extends ConsumerState<_AddCarContent> {
  bool _isLoading = false;

  final _vinController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isDefault = false;

  String? _selectedEngine;
  String? _selectedGear;

  static const List<CarAttributeOption> _engineOptions = [
    CarAttributeOption(
      title: '1.5L',
      iconAsset: 'assets/icons/Vector.svg',
    ),
    CarAttributeOption(
      title: '2.0L Turbo',
      iconAsset: 'assets/icons/Vector.svg',
    ),
  ];

  static const List<CarAttributeOption> _gearOptions = [
    CarAttributeOption(
      title: 'أوتوماتيك',
      iconAsset: 'assets/icons/tabler_automatic-gearbox.svg',
    ),
    CarAttributeOption(
      title: 'عادي',
      iconAsset: 'assets/icons/solar_transmission-linear.svg',
    ),
  ];

  // # Add Car
  Future<void> _addCar() async {
    final vehicleState = ref.read(vehicleProvider);

    if (!_isFormValid(vehicleState) || _isLoading) return;

    final brand = vehicleState.selectedCarBrand!;
    final model = vehicleState.selectedModel!;
    final year = vehicleState.selectedCarYear!;

    final attributes = <UserCarAttributeInput>[
      if (_selectedEngine != null)
        UserCarAttributeInput(
          key: 'engine_capacity',
          value: _selectedEngine!.split('L').first,
        ),
      if (_selectedGear != null)
        UserCarAttributeInput(
          key: 'transmission',
          value: _selectedGear!,
        ),
    ];

    setState(() => _isLoading = true);

    try {
      // # Create Car
      int addedCarId;

      try {
        final addedCar = await ref.read(addUserCarProvider)(
          brandId: brand.id,
          modelId: model.id,
          yearId: year.id,
          vin: _vinController.text,
          nickname: _nicknameController.text.trim().isEmpty
              ? null
              : _nicknameController.text.trim(),
          isDefault: _isDefault,
          attributes: attributes,
        );

        addedCarId = addedCar.id;
      } catch (_) {
        if (!mounted) return;

        await CarStatusDialog.show(
          context: context,
          type: CarDialogType.error,
          title: 'فشلت عملية إضافة السيارة',
          message: 'تعذر إضافة السيارة، الرجاء المحاولة مرة أخرى.',
        );

        return;
      }

      if (!mounted) return;

      // # Set Default Car
      bool defaultCarUpdated = true;

      if (_isDefault) {
        try {
          await ref.read(setDefaultUserCarProvider)(addedCarId);
        } catch (_) {
          defaultCarUpdated = false;
        }
      }

      if (!mounted) return;

      // # Refresh User Cars
      ref.invalidate(userCarsProvider);

      // # Result Dialog
      if (!defaultCarUpdated) {
        await CarStatusDialog.show(
          context: context,
          type: CarDialogType.error,
          title: 'تمت إضافة السيارة',
          message:
              'تمت إضافة سيارتك بنجاح، لكن تعذر تعيينها كسيارة افتراضية. '
              'يمكنك تعيينها لاحقًا من صفحة سياراتي.',
        );
      } else {
        await CarStatusDialog.show(
          context: context,
          type: CarDialogType.success,
          title: 'تمت إضافة سيارتك بنجاح',
          message:
              'ستجد سيارتك الآن في الصفحة الرئيسية '
              'لتتمكن من البحث عن القطع الخاصة بها بكل سهولة.',
        );
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // # Form Validation
  bool _isFormValid(VehicleState vehicleState) {
    final hasVehicleSelection =
        vehicleState.selectedCarBrand != null &&
        vehicleState.selectedModel != null &&
        vehicleState.selectedCarYear != null;

    final hasValidVin = _vinController.text.length == 17;

    return hasVehicleSelection && hasValidVin;
  }

  // # Dispose
  @override
  void dispose() {
    _vinController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  // # Input Decoration
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: AppTextStyles.regularOverline.copyWith(
        color: AppColors.secondaryText,
      ),
      filled: true,
      fillColor: AppColors.inputFieldAndCards,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.actionText,
          width: 1.2,
        ),
      ),
    );
  }

  // # Required Field Title
  Widget _buildTitleWithStar(String title) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppTextStyles.mediumBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: AppColors.errorText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // # Optional Field Title
  Widget _buildOptionalTitle(String title) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppTextStyles.mediumBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const TextSpan(
            text: ' (اختياري)',
            style: TextStyle(
              color: AppColors.actionText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // # Engine Picker
  Future<void> _showEnginePicker() async {
    final value = await CarAttributeBottomSheet.show(
      context: context,
      title: 'اختر حجم المكينة',
      options: _engineOptions,
    );

    if (!mounted || value == null) return;

    setState(() {
      _selectedEngine = value;
    });
  }

  // # Gear Picker
  Future<void> _showGearPicker() async {
    final value = await CarAttributeBottomSheet.show(
      context: context,
      title: 'اختر نوع القير',
      options: _gearOptions,
    );

    if (!mounted || value == null) return;

    setState(() {
      _selectedGear = value;
    });
  }

  // # Build
  @override
  Widget build(BuildContext context) {
    // # Independent Vehicle State
    final vehicleState = ref.watch(vehicleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: 'إضافة سيارة'),
      body: SafeArea(
        child: AppPagePadding(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h16,

                      Text(
                        'بيانات سيارتي',
                        style: AppTextStyles.boldBody,
                      ),

                      h16,

                      // # Vehicle Labels
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: _buildTitleWithStar('البراند'),
                          ),
                          Expanded(
                            child: _buildTitleWithStar('الموديل'),
                          ),
                          Expanded(
                            child: _buildTitleWithStar('السنة'),
                          ),
                        ],
                      ),

                      h8,

                      // # Vehicle Selector
                      const VehiclesWidget(
                        inlineSelection: true,
                      ),

                      h16,

                      // # VIN
                      _buildTitleWithStar('رقم الشاصي (VIN)'),

                      h8,

                      TextField(
                        controller: _vinController,
                        textDirection: TextDirection.ltr,
                        textCapitalization:
                            TextCapitalization.characters,
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (_) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-HJ-NPR-Z0-9]'),
                          ),
                          LengthLimitingTextInputFormatter(17),
                        ],
                        style: AppTextStyles.mediumCaption,
                        decoration: _buildInputDecoration(
                          'رقم الشاصي (VIN)',
                        ),
                      ),

                      h16,

                      // # Vehicle Attributes
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                _buildOptionalTitle('المكينة'),
                                h8,
                                VehicleFilterField(
                                  title: _selectedEngine ?? 'المكينة',
                                  isValueSelected:
                                      _selectedEngine != null,
                                  onTap: _showEnginePicker,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                _buildOptionalTitle('القير'),
                                h8,
                                VehicleFilterField(
                                  title: _selectedGear ?? 'القير',
                                  isValueSelected:
                                      _selectedGear != null,
                                  onTap: _showGearPicker,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      h16,

                      // # Nickname
                      _buildOptionalTitle('اسم السيارة'),

                      h8,

                      TextField(
                        controller: _nicknameController,
                        maxLength: 25,
                        maxLengthEnforcement:
                            MaxLengthEnforcement.enforced,
                        style: AppTextStyles.mediumCaption,
                        decoration: _buildInputDecoration(
                          'مثلاً: "سيارتي، سيارة الوالد"',
                        ),
                      ),

                      h16,

                      // # Default Car
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDefault = !_isDefault;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 150,
                                ),
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.2,
                                    color: AppColors.border,
                                  ),
                                  color: _isDefault
                                      ? AppColors.actionText
                                      : const Color(0xFFF4F5F6),
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                child: _isDefault
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),

                              w8,

                              Text(
                                'تعيين كسيارتي الإفتراضية',
                                style: AppTextStyles.mediumBody.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      h16,
                    ],
                  ),
                ),
              ),

              // # Add Car Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ButtonWidget(
                  text: _isLoading
                      ? 'جاري الإضافة...'
                      : 'إضافة السيارة',
                  width: double.infinity,
                  height: 52,
                  enabled:
                      _isFormValid(vehicleState) && !_isLoading,
                  onPressed: _addCar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
