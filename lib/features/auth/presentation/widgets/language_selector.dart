// import 'package:flutter/material.dart';
// import '../../../../core/theme/app_colors.dart';

// class LanguageSelector extends StatelessWidget {
//   final Locale currentLocale;
//   final ValueChanged<Locale> onChanged;

//   const LanguageSelector({
//     super.key,
//     required this.currentLocale,
//     required this.onChanged,
//   });

//   static const _languages = [
//     _LanguageOption('EN', Locale('en'), 'English'),
//     _LanguageOption('RU', Locale('ru'), 'Русский'),
//     _LanguageOption('KK', Locale('kk'), 'Қазақша'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: _languages.map((option) {
//         return _LanguageChip(
//           option: option,
//           isSelected: currentLocale.languageCode == option.locale.languageCode,
//           onTap: () => onChanged(option.locale),
//         );
//       }).toList(),
//     );
//   }
// }

// class _LanguageOption {
//   final String code;
//   final Locale locale;
//   final String name;

//   const _LanguageOption(this.code, this.locale, this.name);
// }

// class _LanguageChip extends StatelessWidget {
//   final _LanguageOption option;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const _LanguageChip({
//     required this.option,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.only(left: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.primary : AppColors.neutral100,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? AppColors.primary : AppColors.neutral200,
//           ),
//         ),
//         child: Text(
//           option.code,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w700,
//             color: isSelected ? Colors.white : AppColors.neutral600,
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:medical_appointment_app/core/theme/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final ValueChanged<Locale> onChanged;

  const LanguageSelector({
    super.key,
    required this.currentLocale,
    required this.onChanged,
  });

  static const _languages = [
    ('EN', Locale('en'), 'English'),
    ('RU', Locale('ru'), 'Русский'),
    ('KK', Locale('kk'), 'Қазақша'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, 
      children: _languages.map((item) {
        final code = item.$1;
        final locale = item.$2;
        final isSelected = currentLocale.languageCode == locale.languageCode;

        return GestureDetector(
          onTap: () => onChanged(locale),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.neutral100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.neutral200,
              ),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.neutral600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}