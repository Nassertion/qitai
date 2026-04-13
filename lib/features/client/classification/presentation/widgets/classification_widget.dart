import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class ClassificationWidget extends ConsumerStatefulWidget {
  const ClassificationWidget({super.key});

  @override
  ConsumerState<ClassificationWidget> createState() =>
      _ClassificationWidgetState();
}

class _ClassificationWidgetState extends ConsumerState<ClassificationWidget> {
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

    // appBar: CustomAppbar(title: "التصنيف"),
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const VehicleSelectorSection(),

        // if (state.errorMessage != null) ...[
        //   const SizedBox(height: 12),
        //   Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
        // ],
      ],
    );
  }
}
