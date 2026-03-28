import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/features/client/temp_model/temp_client_model.dart';

// ClientInfo clientInfo = ClientInfo(city: "الرياض", distrect: "العزيزية");
// bool hasAddress = clientInfo.city.isNotEmpty && clientInfo.distrect.isNotEmpty;
//real data

// AppBar appBar() {
class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomeAppbar({super.key});

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroudColor,
      titleSpacing: 0,
      elevation: 0,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              "assets/icons/location-add.svg",
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              "عنواني",
              style: AppTextStyles.mediumBody,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/icons/notification-bing.svg",
                    width: 24,
                    height: 24,
                  ),

                  // Container(
                  //   width: 12,
                  //   height: 12,
                  //   child: Text(
                  //     "1",
                  //     style: TextStyle(color: Colors.white, fontSize: 14),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.errorText,
                  //     borderRadius: BorderRadius.circular(32),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
