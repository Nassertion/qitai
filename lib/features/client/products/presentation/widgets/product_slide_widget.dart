import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductViewWidget extends StatefulWidget {
  const ProductViewWidget({super.key});

  @override
  State<ProductViewWidget> createState() => _ProductViewWidgetState();
}

class _ProductViewWidgetState extends State<ProductViewWidget> {
  final PageController _controller = PageController();

  final List<String> banners = [
    'assets/images/product_test.png',
    'assets/images/product_test.png',
   
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
          height: 240,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  banners[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),

        // const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _controller,
          count: banners.length,
          effect: const WormEffect(dotHeight: 6, dotWidth: 6, spacing: 6),
        ),
      ],
    );
  }
}
