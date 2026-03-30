import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ClientBannerSlider extends StatefulWidget {
  const ClientBannerSlider({super.key});

  @override
  State<ClientBannerSlider> createState() => _ClientBannerSliderState();
}

class _ClientBannerSliderState extends State<ClientBannerSlider> {
  final PageController _controller = PageController();

  final List<String> banners = [
    'assets/icons/Ad1.svg',
    'assets/icons/Ad1.svg',
    'assets/icons/Ad1.svg',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 135,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SvgPicture.asset(
                    banners[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _controller,
          count: banners.length,
          effect: const WormEffect(dotHeight: 6, dotWidth: 6, spacing: 6),
        ),
      ],
    );
  }
}
