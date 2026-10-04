import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/user/presentation/widgets/car_attribute_bottom_sheet.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicles_widget.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  final _vinController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isDefault = false;

  String? _selectedEngine;
  String? _selectedGear;

  static const List<CarAttributeOption> _engineOptions = [
    CarAttributeOption(title: '1.5L', iconAsset: 'assets/icons/Vector.svg'),
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

  @override
  void dispose() {
    _vinController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: AppTextStyles.regularOverline.copyWith(
        color: AppColors.secondaryText,
      ),
      filled: true,
      fillColor: AppColors.inputFieldAndCards,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.actionText, width: 1.2),
      ),
    );
  }

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
            style: TextStyle(color: AppColors.actionText, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Future<void> _showEnginePicker() async {
    final value = await CarAttributeBottomSheet.show(
      context: context,
      title: 'اختر حجم المكينة',
      options: _engineOptions,
    );

    if (value == null) {
      return;
    }

    setState(() {
      _selectedEngine = value;
    });
  }

  Future<void> _showGearPicker() async {
    final value = await CarAttributeBottomSheet.show(
      context: context,
      title: 'اختر نوع القير',
      options: _gearOptions,
    );

    if (value == null) {
      return;
    }

    setState(() {
      _selectedGear = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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

                      Text('بيانات سيارتي', style: AppTextStyles.boldBody),

                      h16,

                      Row(
                        spacing: 16,
                        children: [
                          Expanded(child: _buildTitleWithStar('البراند')),
                          Expanded(child: _buildTitleWithStar('الموديل')),
                          Expanded(child: _buildTitleWithStar('السنة')),
                        ],
                      ),

                      h8,

                      const VehiclesWidget(inlineSelection: true),

                      h16,

                      _buildTitleWithStar('رقم الشاصي (VIN)'),

                      h8,

                      TextField(
                        controller: _vinController,
                        textCapitalization: TextCapitalization.characters,
                        autocorrect: false,
                        enableSuggestions: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-HJ-NPR-Z0-9]'),
                          ),
                          LengthLimitingTextInputFormatter(17),
                        ],
                        style: AppTextStyles.mediumCaption,

                        decoration: _buildInputDecoration('رقم الشاصي (VIN)'),
                      ),

                      h16,

                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildOptionalTitle('المكينة'),

                                h8,

                                VehicleFilterField(
                                  title: _selectedEngine ?? 'المكينة',
                                  isValueSelected: _selectedEngine != null,
                                  onTap: _showEnginePicker,
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildOptionalTitle('القير'),

                                h8,

                                VehicleFilterField(
                                  title: _selectedGear ?? 'القير',
                                  isValueSelected: _selectedGear != null,
                                  onTap: _showGearPicker,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      h16,

                      _buildOptionalTitle('اسم السيارة'),

                      h8,

                      TextField(
                        controller: _nicknameController,
                        style: AppTextStyles.mediumCaption,
                        decoration: _buildInputDecoration(
                          'مثلاً: "سيارتي، سيارة الوالد"',
                        ),
                      ),

                      h16,

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
                                duration: const Duration(milliseconds: 150),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.2,
                                    color: AppColors.border,
                                  ),
                                  color: _isDefault
                                      ? AppColors.actionText
                                      : const Color(0xFFF4F5F6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _isDefault
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
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

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ButtonWidget(
                  text: 'إضافة السيارة',
                  width: double.infinity,
                  height: 52,
                  enabled: false,
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
