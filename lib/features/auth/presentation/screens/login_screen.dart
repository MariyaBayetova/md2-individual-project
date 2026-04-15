// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/core/utils/validators.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/error/firebase_auth_error_mapper.dart';
// import '../../../../core/providers/app_providers.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/app_button.dart';
// import '../../../../core/widgets/app_text_field.dart';
// import '../providers/auth_providers.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passCtrl = TextEditingController();

//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;
//     await ref
//         .read(authNotifierProvider.notifier)
//         .login(_emailCtrl.text.trim(), _passCtrl.text.trim());
//     if (!mounted) return;
//     final state = ref.read(authNotifierProvider);
//     if (state.hasError) {
//       final message = mapFirebaseAuthError(state.error!);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: AppColors.error,
//         ),
//       );
//     } else if (state.hasValue && state.value != null) {
//       context.go(Routes.home);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context)!;
//     final authState = ref.watch(authNotifierProvider);
//     final locale = ref.watch(localeProvider);
//     final size = MediaQuery.sizeOf(context);
//     final isWide = size.width > 600;

//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: isWide ? size.width * 0.2 : 24,
//               vertical: 32,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   //  Language selector 
//                   _LanguageSelector(
//                     currentLocale: locale,
//                     onChanged: (loc) =>
//                         ref.read(localeProvider.notifier).state = loc,
//                   ),
//                   const SizedBox(height: 24),

                
//                   Center(
//                     child: Container(
//                       width: 72,
//                       height: 72,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryContainer,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Icon(
//                         Icons.local_hospital_rounded,
//                         color: AppColors.primary,
//                         size: 42,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     l.welcomeBack,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineSmall
//                         ?.copyWith(fontWeight: FontWeight.w700),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     l.signInToAccount,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: AppColors.neutral600),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 36),

//                   //  Email 
//                   AppTextField(
//                     label: l.email,
//                     controller: _emailCtrl,
//                     keyboardType: TextInputType.emailAddress,
//                     prefixIcon: Icons.email_outlined,
//                     validator: (v) => validateEmail(v),
//                   ),
//                   const SizedBox(height: 16),

//                   //  Password 
//                   AppTextField(
//                     label: l.password,
//                     controller: _passCtrl,
//                     obscureText: true,
//                     prefixIcon: Icons.lock_outline,
//                     validator: (v) => validatePassword(v),
//                   ),
//                   const SizedBox(height: 28),

//                   AppButton(
//                     label: l.signIn,
//                     isLoading: authState.isLoading,
//                     onPressed: authState.isLoading ? null : _submit,
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(l.dontHaveAccountQuestion),
//                       TextButton(
//                         onPressed: () => context.push(Routes.register),
//                         child: Text(l.signUp),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //  _LanguageSelector 
// // SRP: только отображает и меняет язык
// class _LanguageSelector extends StatelessWidget {
//   final Locale currentLocale;
//   final ValueChanged<Locale> onChanged;

//   const _LanguageSelector({
//     required this.currentLocale,
//     required this.onChanged,
//   });

//   static const _languages = [
//     ('EN', Locale('en'), 'English'),
//     ('RU', Locale('ru'), 'Русский'),
//     ('KK', Locale('kk'), 'Қазақша'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: _languages.map((item) {
//         final code = item.$1;
//         final locale = item.$2;
//         final isSelected = currentLocale.languageCode == locale.languageCode;

//         return GestureDetector(
//           onTap: () => onChanged(locale),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             margin: const EdgeInsets.only(left: 6),
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? AppColors.primary
//                   : AppColors.neutral100,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: isSelected
//                     ? AppColors.primary
//                     : AppColors.neutral200,
//               ),
//             ),
//             child: Text(
//               code,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//                 color: isSelected ? Colors.white : AppColors.neutral600,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/core/utils/validators.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/error/firebase_auth_error_mapper.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import '../widgets/language_selector.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).login(
          _emailCtrl.text.trim(),
          _passCtrl.text.trim(),
        );
    if (!mounted) return;
    final state = ref.read(authNotifierProvider);
    if (state.hasError) {
      final message = mapFirebaseAuthError(state.error!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.error),
      );
    } else if (state.hasValue && state.value != null) {
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final locale = ref.watch(localeProvider);
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              vertical: 32,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.local_hospital_rounded,
                        color: AppColors.primary,
                        size: 42,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l.welcomeBack,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l.signInToAccount,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.neutral600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),

                  AppTextField(
                    label: l.email,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (v) => validateEmail(v),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: l.password,
                    controller: _passCtrl,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: (v) => validatePassword(v),
                  ),
                  const SizedBox(height: 28),

                  AppButton(
                    label: l.signIn,
                    isLoading: authState.isLoading,
                    onPressed: authState.isLoading ? null : _submit,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l.dontHaveAccountQuestion),
                      TextButton(
                        onPressed: () => context.push(Routes.register),
                        child: Text(l.signUp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}