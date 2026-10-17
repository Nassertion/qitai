import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/features/client/user/cars/presentation/providers/add_car_vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class VehiclesWidget extends ConsumerStatefulWidget {
  final bool inlineSelection;
  final bool useAddCarProvider;

  const VehiclesWidget({
    super.key,
    this.inlineSelection = false,
    this.useAddCarProvider = false,
  });

  @override
  ConsumerState<VehiclesWidget> createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends ConsumerState<VehiclesWidget> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      if (widget.useAddCarProvider) {
        ref.read(addCarVehicleProvider.notifier).loadBrands();
      } else {
        ref.read(vehicleProvider.notifier).loadBrands();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        VehicleSelectorSection(
          inlineSelection: widget.inlineSelection,
          useAddCarProvider: widget.useAddCarProvider,
        ),
      ],
    );
  }
}
