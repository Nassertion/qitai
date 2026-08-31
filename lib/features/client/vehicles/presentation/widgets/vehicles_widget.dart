import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class VehiclesWidget extends ConsumerStatefulWidget {
  const VehiclesWidget({super.key});

  @override
  ConsumerState<VehiclesWidget> createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends ConsumerState<VehiclesWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(vehicleProvider.notifier).loadBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(classificationProvider);

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
