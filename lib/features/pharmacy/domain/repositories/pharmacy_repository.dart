import '../entities/drug_entity.dart';

abstract class PharmacyRepository {
  Future<List<DrugEntity>> searchDrugs(String query);
  Future<List<DrugEntity>> getPopularDrugs();
}
