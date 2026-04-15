import '../../domain/entities/drug_entity.dart';

class DrugModel extends DrugEntity {
  const DrugModel({
    required super.id,
    required super.brandName,
    required super.genericName,
    required super.manufacturer,
    required super.purpose,
    required super.description,
    required super.dosageForm,
    required super.route,
    required super.price,
    required super.rating,
    required super.inStock,
  });

  // Maps a single result from OpenFDA /drug/label.json
  factory DrugModel.fromOpenFda(Map<String, dynamic> json, int index) {
    String first(dynamic field) {
      if (field is List && field.isNotEmpty) return field.first as String;
      return '';
    }

    final openfda = json['openfda'] as Map<String, dynamic>? ?? {};
    final brandName = first(openfda['brand_name']) .isNotEmpty
        ? first(openfda['brand_name'])
        : first(openfda['generic_name']);
    final genericName = first(openfda['generic_name']);
    final manufacturer = first(openfda['manufacturer_name']);
    final purpose = first(json['purpose']);
    final description = first(json['description'])
        .isNotEmpty
        ? first(json['description'])
        : first(json['indications_and_usage']);
    final dosageForm = first(openfda['dosage_form']);
    final route = first(openfda['route']);

    return DrugModel(
      id: '${brandName}_$index'.replaceAll(' ', '_').toLowerCase(),
      brandName: brandName.isNotEmpty ? brandName : 'Unknown',
      genericName: genericName.isNotEmpty ? genericName : brandName,
      manufacturer: manufacturer.isNotEmpty ? manufacturer : 'N/A',
      purpose: purpose.isNotEmpty ? purpose : 'See description',
      description: description.isNotEmpty
          ? description
          : 'No description available.',
      dosageForm: dosageForm.isNotEmpty ? dosageForm : 'Tablet',
      route: route.isNotEmpty ? route : 'Oral',
      price: 500.0 + (index % 20) * 250.0,
      rating: 3.5 + (index % 15) * 0.1,
      inStock: index % 7 != 0,
    );
  }
}
