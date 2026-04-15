import '../entities/drug_entity.dart';
import '../repositories/pharmacy_repository.dart';

class GetPopularDrugsUseCase {
  final PharmacyRepository repository;
  GetPopularDrugsUseCase(this.repository);

  Future<List<DrugEntity>> call() => repository.getPopularDrugs();
}
