import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';

class FilterDemoPage extends StatefulWidget {
  const FilterDemoPage({super.key});

  @override
  State<FilterDemoPage> createState() => _FilterDemoPageState();
}

class _FilterDemoPageState extends State<FilterDemoPage> {
  final List<String> brands = [
    'تويوتا',
    'هيونداي',
    'نيسان',
    'كيا',
    'مرسيدس',
    'BMW',
  ];
  final List<String> models = [
    'كامري',
    'اكسنت',
    'النترا',
    'ني فايف',
    'باترول',
    'افالون',
  ];
  final List<String> year = ['2002', '2001', '2000'];
  // final List<String> cate = ['كهرباء', 'ماء', 'فلاتر', 'مكينه', 'بواجي'];

  String? selectedBrand;
  String? selectedModel;
  String? selectedYear;
  // String? selectedCate;

  Future<void> showBrandBottomSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.inputFieldAndCards,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xffB5BBC2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              dPadding,

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اختر نوع البراند',
                  style: AppTextStyles.boldBody.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              dPadding,
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: brands.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    // final item = brands[index];
                    // final isSelected = item == selectedBrand;

                    return InkWell(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Logo.svg.svg",
                                height: 20,
                                width: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "نيسان",
                                style: AppTextStyles.mediumCaption.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          dPadding,
                          Divider(color: AppColors.border),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedBrand = result;
      });
    }
  }

  GestureDetector test(String title) {
    return GestureDetector(
      onTap: showBrandBottomSheet,
      child: Container(
        // width: 75,
        height: 35,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.inputFieldAndCards,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.regularOverline.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/arrow-down.svg",
                height: 16,
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "test"),
      body: AppPagePadding(
        child: ListView(
          children: [
            dPadding,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                Expanded(child: test("البراند")),
                Expanded(child: test("الموديل")),
                Expanded(child: test("السنة")),
                // Expanded(child: test("القسم")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
