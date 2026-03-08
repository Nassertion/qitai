import 'package:flutter/material.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/app_bar.dart';
import 'package:qitai/core/widgets/search.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //real data
      backgroundColor: Color.fromRGBO(239, 240, 242, 1),
      appBar: appBar(),
      body: AppPagePadding(
        child: Column(
          children: [
            Dpadding,
            search(),
            Dpadding,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("سيارتي"), Text("عرض الكل")],
            ),
          ],
        ),
      ),
    );
  }
}
