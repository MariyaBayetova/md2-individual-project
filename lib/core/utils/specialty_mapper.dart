import 'package:flutter/material.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';


class SpecialtyMapper {
 

 
  static const cardiologist = 'Cardiologist';
  static const neurologist = 'Neurologist';
  static const dentist = 'Dentist';
  static const pediatrician = 'Pediatrician';
  static const dermatologist = 'Dermatologist';


  static const all = [
    cardiologist,
    neurologist,
    dentist,
    pediatrician,
    dermatologist,
  ];

 

 


  static String translate(String englishSpecialty, AppLocalizations l) {
    return switch (englishSpecialty) {
      cardiologist => l.cardiologist,
      neurologist => l.neurologist,
      dentist => l.dentist,
      pediatrician => l.pediatrician,
      dermatologist => l.dermatologist,
      _ => englishSpecialty, 
    };
  }


  static String toEnglish(String translatedSpecialty, AppLocalizations l) {
    if (translatedSpecialty == l.cardiologist) return cardiologist;
    if (translatedSpecialty == l.neurologist) return neurologist;
    if (translatedSpecialty == l.dentist) return dentist;
    if (translatedSpecialty == l.pediatrician) return pediatrician;
    if (translatedSpecialty == l.dermatologist) return dermatologist;
    return translatedSpecialty; 
  }

 
  static IconData getIcon(String englishSpecialty) {
    return switch (englishSpecialty) {
      cardiologist => Icons.favorite_outline,
      neurologist => Icons.psychology_outlined,
      dentist => Icons.medical_services_outlined,
      pediatrician => Icons.child_care_outlined,
      dermatologist => Icons.spa_outlined,
      _ => Icons.local_hospital_outlined,
    };
  }

 

  static Color getColor(String englishSpecialty) {
    return switch (englishSpecialty) {
      cardiologist => const Color(0xFFEF4444),    
      neurologist => const Color(0xFF8B5CF6),     
      dentist => const Color(0xFF06B6D4),        
      pediatrician => const Color(0xFFF59E0B),    
      dermatologist => const Color(0xFF10B981), 
      _ => const Color(0xFF6366F1),               
    };
  }
}