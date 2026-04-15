// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import '../../../../core/di/injection.dart';
// import '../../domain/entities/doctor_entity.dart';
// import '../../domain/usecases/get_doctors_usecase.dart';

// final selectedSpecialtyProvider = StateProvider<String?>((ref) => null);

// final doctorsProvider =
//     FutureProvider.family<List<DoctorEntity>, String?>((ref, specialty) async {
//   return sl<GetDoctorsUseCase>().call(specialty: specialty);
// });

// final allDoctorsProvider = FutureProvider<List<DoctorEntity>>((ref) {
//   final specialty = ref.watch(selectedSpecialtyProvider);
//   return ref.watch(doctorsProvider(specialty).future);
// });

// final doctorSearchQueryProvider = StateProvider<String>((ref) => '');

// final filteredDoctorsProvider =
//     Provider<AsyncValue<List<DoctorEntity>>>((ref) {
//   final query = ref.watch(doctorSearchQueryProvider).toLowerCase();
//   final docs = ref.watch(allDoctorsProvider);
//   if (query.isEmpty) return docs;
//   return docs.whenData(
//     (list) => list
//         .where((d) =>
//             d.name.toLowerCase().contains(query) ||
//             d.specialty.toLowerCase().contains(query))
//         .toList(),
//   );
// });


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/usecases/get_doctors_usecase.dart';



/// Получить всех врачей
final allDoctorsProvider = FutureProvider<List<DoctorEntity>>((ref) async {
  return await sl<GetDoctorsUseCase>().call();
});

/// Выбранная специальность
final selectedSpecialtyProvider = StateProvider<String?>((ref) => null);

/// Поисковый запрос
final doctorSearchQueryProvider = StateProvider<String>((ref) => '');

/// Отфильтрованные врачи
final filteredDoctorsProvider = Provider<AsyncValue<List<DoctorEntity>>>((ref) {
  final allDoctors = ref.watch(allDoctorsProvider);
  final selectedSpecialty = ref.watch(selectedSpecialtyProvider);
  final searchQuery = ref.watch(doctorSearchQueryProvider).toLowerCase();

  return allDoctors.whenData((doctors) {
    var filtered = doctors;

    // Фильтр по специальности
    if (selectedSpecialty != null) {
      filtered = filtered.where((d) {
        // Сравнение без учёта регистра
        return d.specialty.toLowerCase() == selectedSpecialty.toLowerCase();
      }).toList();
    }

    // Фильтр по поисковому запросу
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((d) {
        final name = d.name.toLowerCase();
        final specialty = d.specialty.toLowerCase();
        return name.contains(searchQuery) || specialty.contains(searchQuery);
      }).toList();
    }

    return filtered;
  });
});