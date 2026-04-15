// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/providers/app_providers.dart';
// import '../widgets/language_selector.dart';
// import '../widgets/register_form.dart';

// class RegisterScreen extends ConsumerWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final locale = ref.watch(localeProvider);
//     final size = MediaQuery.sizeOf(context);
//     final isWide = size.width > 600;

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: isWide ? size.width * 0.2 : 24,
//               vertical: 16,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 LanguageSelector(
//                   currentLocale: locale,
//                   onChanged: (loc) =>
//                       ref.read(localeProvider.notifier).state = loc,
//                 ),
//                 const SizedBox(height: 24),
//                 const RegisterForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/providers/app_providers.dart';
import '../widgets/language_selector.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        leading: const BackButton(color: Colors.black), 
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: LanguageSelector(
              currentLocale: locale,
              onChanged: (loc) => ref.read(localeProvider.notifier).state = loc,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? size.width * 0.2 : 24,
              vertical: 16,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}