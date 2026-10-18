import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class VehiclesWidget extends ConsumerStatefulWidget {
  const VehiclesWidget({
    super.key,
    this.inlineSelection = false,
    this.useAddCarProvider = false,
  });

  final bool inlineSelection;
  final bool useAddCarProvider;

  @override
  ConsumerState<VehiclesWidget> createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends ConsumerState<VehiclesWidget> {
  VehicleScope get _scope =>
      widget.useAddCarProvider ? VehicleScope.addCar : VehicleScope.browse;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      ref.read(vehicleProvider(_scope).notifier).loadBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VehicleSelectorSection(
      inlineSelection: widget.inlineSelection,
      useAddCarProvider: widget.useAddCarProvider,
    );
  }
}
