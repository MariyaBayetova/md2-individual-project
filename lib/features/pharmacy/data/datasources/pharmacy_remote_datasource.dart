import 'package:dio/dio.dart';
import '../models/drug_model.dart';

abstract class PharmacyRemoteDataSource {
  Future<List<DrugModel>> searchDrugs(String query);
  Future<List<DrugModel>> getPopularDrugs();
}

class PharmacyRemoteDataSourceImpl implements PharmacyRemoteDataSource {
  final Dio dio;

  // OpenFDA has its own base URL — we use a separate Dio instance
  static const _baseUrl = 'https://api.fda.gov/drug/label.json';

  PharmacyRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DrugModel>> searchDrugs(String query) async {
    try {
      final response = await dio.get(
        _baseUrl,
        options: Options(
          // Override baseUrl for this specific call
          extra: {'skipBaseUrl': true},
        ),
        queryParameters: {
          'search': 'openfda.brand_name:"$query"+openfda.generic_name:"$query"',
          'limit': 20,
        },
      );
      return _parse(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  @override
  Future<List<DrugModel>> getPopularDrugs() async {
    try {
      final response = await dio.get(
        _baseUrl,
        options: Options(extra: {'skipBaseUrl': true}),
        queryParameters: {
          'search': 'openfda.product_type:"OTC"',
          'limit': 20,
        },
      );
      return _parse(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  List<DrugModel> _parse(dynamic data) {
    final results = (data['results'] as List<dynamic>?) ?? [];
    return results
        .asMap()
        .entries
        .map((e) => DrugModel.fromOpenFda(e.value as Map<String, dynamic>, e.key))
        .toList();
  }
}
