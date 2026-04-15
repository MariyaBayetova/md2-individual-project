import 'package:equatable/equatable.dart';

class HospitalEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String type; // 'hospital' | 'clinic' | 'emergency'
  final double latitude;
  final double longitude;
  final double rating;
  final bool isOpen24h;
  final bool hasEmergency;
  final String distance; // e.g. '1.2 km'

  const HospitalEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.isOpen24h,
    required this.hasEmergency,
    required this.distance,
  });

  @override
  List<Object?> get props => [id];
}
