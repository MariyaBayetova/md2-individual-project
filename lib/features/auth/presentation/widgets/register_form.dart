import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/error/firebase_auth_error_mapper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_providers.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authNotifierProvider.notifier).register(
          _emailCtrl.text.trim(),
          _passCtrl.text.trim(),
          _firstNameCtrl.text.trim(),
          _lastNameCtrl.text.trim(),
        );

    if (!mounted) return;

    final state = ref.read(authNotifierProvider);

    if (state.hasError) {
      _showError(mapFirebaseAuthError(state.error!));
    } else if (state.hasValue && state.value != null) {
      context.go(Routes.home);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, l),
          const SizedBox(height: 28),

          // First Name
          AppTextField(
            label: l.firstName,
            controller: _firstNameCtrl,
            prefixIcon: Icons.person_outline,
            validator: validateName,
          ),
          const SizedBox(height: 14),

          // Last Name
          AppTextField(
            label: l.lastName,
            controller: _lastNameCtrl,
            prefixIcon: Icons.person_outline,
            validator: validateSurname,
          ),
          const SizedBox(height: 14),

          // Email
          AppTextField(
            label: l.email,
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: validateEmail,
          ),
          const SizedBox(height: 14),

          // Password
          AppTextField(
            label: l.password,
            controller: _passCtrl,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
            validator: validatePassword,
          ),
          const SizedBox(height: 14),

          // Confirm Password
          AppTextField(
            label: l.confirmPassword,
            controller: _confirmCtrl,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
            validator: (v) {
              if (v == null || v.isEmpty) return l.requiredField;
              if (v != _passCtrl.text) return l.passwordsDoNotMatch;
              return null;
            },
          ),
          const SizedBox(height: 28),

          // Submit Button
          AppButton(
            label: l.createAccount,
            isLoading: authState.isLoading,
            onPressed: authState.isLoading ? null : _submit,
          ),
          const SizedBox(height: 16),

          // Footer
          _buildFooter(context, l),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.createAccount,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          l.fillDetails,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.neutral600),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations l) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l.alreadyHaveAccountQuestion),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l.signIn),
        ),
      ],
    );
  }
}