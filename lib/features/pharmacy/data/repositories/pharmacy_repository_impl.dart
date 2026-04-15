import '../../../../core/network/network_info.dart';
import '../../domain/entities/drug_entity.dart';
import '../../domain/repositories/pharmacy_repository.dart';
import '../datasources/pharmacy_remote_datasource.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  final PharmacyRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  // Simple in-memory cache for cache-then-network pattern
  List<DrugEntity>? _popularCache;
  final Map<String, List<DrugEntity>> _searchCache = {};

  PharmacyRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<DrugEntity>> getPopularDrugs() async {
    // Return cache immediately if available (cache-then-network)
    if (_popularCache != null) return _popularCache!;

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return _popularCache ?? [];

    final result = await remoteDataSource.getPopularDrugs();
    _popularCache = result;
    return result;
  }

  @override
  Future<List<DrugEntity>> searchDrugs(String query) async {
    if (query.trim().isEmpty) return getPopularDrugs();

    final cacheKey = query.toLowerCase().trim();
    if (_searchCache.containsKey(cacheKey)) return _searchCache[cacheKey]!;

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return [];

    final result = await remoteDataSource.searchDrugs(query);
    _searchCache[cacheKey] = result;
    return result;
  }
}
