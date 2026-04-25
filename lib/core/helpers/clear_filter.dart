import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';

void clearClassificationFilters(WidgetRef ref) {
  ref.read(classificationProvider.notifier).clearAll();
}