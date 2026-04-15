import 'package:equatable/equatable.dart';

class DrugEntity extends Equatable {
  final String id;
  final String brandName;
  final String genericName;
  final String manufacturer;
  final String purpose;
  final String description;
  final String dosageForm;
  final String route;
  final double price;
  final double rating;
  final bool inStock;

  const DrugEntity({
    required this.id,
    required this.brandName,
    required this.genericName,
    required this.manufacturer,
    required this.purpose,
    required this.description,
    required this.dosageForm,
    required this.route,
    required this.price,
    required this.rating,
    required this.inStock,
  });

  @override
  List<Object?> get props => [id, brandName, genericName];
}
