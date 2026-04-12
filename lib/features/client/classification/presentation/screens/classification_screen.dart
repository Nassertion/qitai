import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class ClassificationScreen extends ConsumerStatefulWidget {
  const ClassificationScreen({super.key});

  @override
  ConsumerState<ClassificationScreen> createState() =>
      _ClassificationScreenState();
}

class _ClassificationScreenState
    extends ConsumerState<ClassificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(classificationProvider.notifier).loadBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(classificationProvider);

    return Scaffold(
      // appBar: CustomAppbar(title: "التصنيف"),
      body: AppPagePadding(
        child: ListView(
          children: [
            const VehicleSelectorSection(),

            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}