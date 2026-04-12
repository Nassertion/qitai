import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/dio_provider.dart';
import 'package:qitai/features/client/vehicles/data/repository/vehicles_repository.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';

final classificationRepositoryProvider = Provider<ClassificationRepository>((ref) {
  final dio = ref.read(dioProvider);
  return ClassificationRepository(dio);
});

final classificationProvider =
    NotifierProvider<ClassificationNotifier, ClassificationState>(
  ClassificationNotifier.new,
);