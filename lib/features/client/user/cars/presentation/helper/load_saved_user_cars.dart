import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

Future<List<UserCar>> loadSavedUserCars(WidgetRef ref) async {
  if (ref.read(authProvider) is! Authenticated) {
    return const [];
  }

  try {
    final cachedCars = ref.read(userCarsProvider).asData?.value;
    final cars = cachedCars ?? await ref.read(userCarsProvider.future);

    final sortedCars = [...?cars]
      ..sort((a, b) {
        if (a.isDefault == b.isDefault) return 0;
        return a.isDefault ? -1 : 1;
      });

    return sortedCars;
  } catch (_) {
    return const [];
  }
}
