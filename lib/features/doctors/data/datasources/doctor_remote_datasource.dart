import 'package:dio/dio.dart';
import '../models/doctor_model.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getDoctors();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final Dio dio;
  DoctorRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DoctorModel>> getDoctors() async {
    final response = await dio.get(
      '/',
      queryParameters: {'results': 20, 'nat': 'us,gb', 'inc': 'name,login,picture'},
    );
    final results = response.data['results'] as List<dynamic>;
    return results
        .asMap()
        .entries
        .map((e) => DoctorModel.fromRandomUser(
            e.value as Map<String, dynamic>, e.key))
        .toList();
  }
}
