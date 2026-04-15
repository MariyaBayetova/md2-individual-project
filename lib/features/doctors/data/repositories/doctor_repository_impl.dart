import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_remote_datasource.dart';
import '../../../../core/network/network_info.dart';

// Simple in-memory cache
List<DoctorEntity>? _cachedDoctors;

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<DoctorEntity>> getDoctors({String? specialty}) async {
    // Cache-then-network pattern
    if (_cachedDoctors != null) {
      final cached = specialty == null
          ? _cachedDoctors!
          : _cachedDoctors!
              .where((d) =>
                  d.specialty.toLowerCase() == specialty.toLowerCase())
              .toList();
      // Fetch fresh in background if online
      _refreshInBackground();
      return cached;
    }
    final doctors = await remoteDataSource.getDoctors();
    _cachedDoctors = doctors;
    if (specialty == null) return doctors;
    return doctors
        .where(
            (d) => d.specialty.toLowerCase() == specialty.toLowerCase())
        .toList();
  }

  void _refreshInBackground() async {
    if (!await networkInfo.isConnected) return;
    try {
      final fresh = await remoteDataSource.getDoctors();
      _cachedDoctors = fresh;
    } catch (_) {}
  }

  @override
  Future<DoctorEntity> getDoctorById(String id) async {
    final all = await getDoctors();
    return all.firstWhere((d) => d.id == id);
  }
}
