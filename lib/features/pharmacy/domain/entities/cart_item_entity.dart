import 'package:equatable/equatable.dart';
import 'drug_entity.dart';

class CartItemEntity extends Equatable {
  final DrugEntity drug;
  final int quantity;

  const CartItemEntity({required this.drug, required this.quantity});

  double get totalPrice => drug.price * quantity;

  CartItemEntity copyWith({int? quantity}) =>
      CartItemEntity(drug: drug, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [drug.id, quantity];
}
