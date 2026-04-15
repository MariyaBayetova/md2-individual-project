import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/hospital_entity.dart';
import '../../domain/usecases/get_hospitals_usecase.dart';

final hospitalsProvider = FutureProvider<List<HospitalEntity>>((ref) async {
  return sl<GetHospitalsUseCase>().call();
});

// Filter: 'all' | 'hospital' | 'clinic' | 'emergency'
final hospitalFilterProvider = StateProvider<String>((ref) => 'all');

final filteredHospitalsProvider =
    Provider<AsyncValue<List<HospitalEntity>>>((ref) {
  final filter = ref.watch(hospitalFilterProvider);
  final hospitals = ref.watch(hospitalsProvider);
  if (filter == 'all') return hospitals;
  return hospitals.whenData(
    (list) => list.where((h) => h.type == filter).toList(),
  );
});
