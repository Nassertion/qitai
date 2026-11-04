
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_selector_section.dart';

class VehiclesWidget extends ConsumerStatefulWidget {
  const VehiclesWidget({
    super.key,
    this.inlineSelection = false,
  });

  final bool inlineSelection;

  @override
  ConsumerState<VehiclesWidget> createState() =>
      _VehiclesWidgetState();
}

class _VehiclesWidgetState extends ConsumerState<VehiclesWidget> {
  // # Initialize Brands
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final state = ref.read(vehicleProvider);

      // # Avoid Duplicate Requests
      if (state.carBrands.isNotEmpty || state.isBrandsLoading) {
        return;
      }

      unawaited(
        ref.read(vehicleProvider.notifier).loadBrands(),
      );
    });
  }

  // # Build
  @override
  Widget build(BuildContext context) {
    return VehicleSelectorSection(
      inlineSelection: widget.inlineSelection,
    );
  }
}
