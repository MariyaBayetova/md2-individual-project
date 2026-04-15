import 'package:flutter/material.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';

String localizeSpecialty(BuildContext context, String specialty) {
  final l = AppLocalizations.of(context)!;
  return switch (specialty) {
    'Therapist' => l.therapist,
    'Cardiologist' => l.cardiologist,
    'Neurologist' => l.neurologist,
    'Dentist' => l.dentist,
    'Pediatrician' => l.pediatrician,
    'Dermatologist' => l.dermatologist,
    _ => specialty,
  };
}