import '../entities/drug_entity.dart';
import '../repositories/pharmacy_repository.dart';

class SearchDrugsUseCase {
  final PharmacyRepository repository;
  SearchDrugsUseCase(this.repository);

  Future<List<DrugEntity>> call(String query) => repository.searchDrugs(query);
}
