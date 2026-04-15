// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/providers/app_providers.dart';
// import '../../../../core/theme/app_colors.dart';

// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final themeMode = ref.watch(themeModeProvider);
//     final locale = ref.watch(localeProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text(l.settings)),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Card(
//             child: SwitchListTile(
//               secondary: const Icon(Icons.dark_mode_outlined,
//                   color: AppColors.primary),
//               title: Text(l.darkMode),
//               value: themeMode == ThemeMode.dark,
//               activeColor: AppColors.primary,
//               onChanged: (val) {
//                 ref.read(themeModeProvider.notifier).state =
//                     val ? ThemeMode.dark : ThemeMode.light;
//               },
//             ),
//           ),
//           const SizedBox(height: 12),
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(children: [
//                     const Icon(Icons.language, color: AppColors.primary),
//                     const SizedBox(width: 12),
//                     Text(l.language,
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall
//                             ?.copyWith(fontWeight: FontWeight.w600)),
//                   ]),
//                   const SizedBox(height: 12),
//                   ...[
//                     ('English', const Locale('en')),
//                     ('Русский', const Locale('ru')),
//                     ('Қазақша', const Locale('kk')),
//                   ].map((item) => RadioListTile<Locale>(
//                         title: Text(item.$1),
//                         value: item.$2,
//                         groupValue: locale,
//                         activeColor: AppColors.primary,
//                         contentPadding: EdgeInsets.zero,
//                         onChanged: (val) {
//                           if (val != null) {
//                             ref.read(localeProvider.notifier).state = val;
//                           }
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //  Appearance 
_SectionLabel(l.settings),
Card(
  child: SwitchListTile(
    secondary: const Icon(Icons.dark_mode_outlined,
        color: AppColors.primary),
    title: Text(l.darkMode),
    subtitle: Text(l.darkModeDescription), 
    value: themeMode == ThemeMode.dark,
    activeColor: AppColors.primary,
    onChanged: (val) {
      ref.read(themeModeProvider.notifier).state =
          val ? ThemeMode.dark : ThemeMode.light;
    },
  ),
),
          const SizedBox(height: 12),

          //  Language 
          _SectionLabel(l.language),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.language, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(l.language,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ]),
                  const SizedBox(height: 8),
                  ...[
                    ('English', const Locale('en')),
                    ('Русский', const Locale('ru')),
                    ('Қазақша', const Locale('kk')),
                  ].map((item) => RadioListTile<Locale>(
                        title: Text(item.$1),
                        value: item.$2,
                        groupValue: locale,
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(localeProvider.notifier).state = val;
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          //  Account ─
         _SectionLabel(l.account),
Card(
  child: Column(
    children: [
      _SettingsTile(
        icon: Icons.person_outline,
        title: l.profile,
        subtitle: l.viewEditProfile, 
        onTap: () => context.go(Routes.patientCard),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.rate_review_outlined,
        title: l.myReviews, 
        subtitle: l.reviewsDescription, 
        onTap: () => context.push(Routes.myReviews),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.alarm_outlined,
        title: l.medicineReminders, 
        subtitle: l.medicineRemindersDescription, 
        onTap: () => context.go(Routes.reminders),
      ),
    ],
  ),
),
          const SizedBox(height: 12),

          //  Notifications 
          _SectionLabel(l.notifications), 
Card(
  child: Column(
    children: [
      _SettingsTile(
        icon: Icons.notifications_outlined,
        title: l.appointmentReminders, 
        subtitle: l.appointmentRemindersDescription, 
        trailing: Switch(
          value: true,
          activeColor: AppColors.primary,
          onChanged: (_) {},
        ),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.local_pharmacy_outlined,
        title: l.medicineAlerts, 
        subtitle: l.medicineAlertsDescription, 
        trailing: Switch(
          value: true,
          activeColor: AppColors.primary,
          onChanged: (_) {},
        ),
      ),
    ],
  ),
),
          const SizedBox(height: 12),

          //  Support 
_SectionLabel(l.support), 
Card(
  child: Column(
    children: [
      _SettingsTile(
        icon: Icons.help_outline,
        title: l.helpFaq, 
        subtitle: l.helpFaqDescription, 
        onTap: () => _showHelpSheet(context, l),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.mail_outline,
        title: l.contactUs, 
        subtitle: 'support@medica.kz',
        onTap: () => _showContactSheet(context, l),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.bug_report_outlined,
        title: l.reportProblem, 
        subtitle: l.reportProblemDescription, 
        onTap: () => _showReportSheet(context, l),
      ),
    ],
  ),
),
          const SizedBox(height: 12),

          //  About 
_SectionLabel(l.about), 
Card(
  child: Column(
    children: [
      _SettingsTile(
        icon: Icons.info_outline,
        title: l.aboutMedica, 
        subtitle: l.aboutMedicaDescription, 
        onTap: () => _showAboutSheet(context, l),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.privacy_tip_outlined,
        title: l.privacyPolicy, 
        subtitle: l.privacyPolicyDescription, 
        onTap: () => _showPrivacySheet(context, l),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.description_outlined,
        title: l.termsOfService, 
        subtitle: l.termsOfServiceDescription, 
        onTap: () => _showTermsSheet(context, l),
      ),
      _Divider(),
      _SettingsTile(
        icon: Icons.system_update_outlined,
        title: l.appVersion, 
        subtitle: 'Version 1.0.0',
      ),
    ],
  ),
),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  
  // Bottom Sheets
  

void _showAboutSheet(BuildContext context, AppLocalizations l) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.local_hospital_rounded,
                color: AppColors.primary, size: 36),
          ),
          const SizedBox(height: 16),
          Text(l.appName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            l.aboutMedicaFullDescription, 
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.neutral600, height: 1.6),
          ),
          const SizedBox(height: 16),
          Text(l.madeInKazakhstan, 
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.neutral400)),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

void _showContactSheet(BuildContext context, AppLocalizations l) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.contactUs,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _ContactRow(
            icon: Icons.mail_outline,
            label: l.email,
            value: 'support@medica.kz',
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.phone_outlined,
            label: l.phone, 
            value: '+7 (717) 200-00-00',
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.access_time_outlined,
            label: l.supportHours, 
            value: l.supportHoursValue, 
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.location_on_outlined,
            label: l.address, 
            value: 'Turan Ave 5, Astana, Kazakhstan',
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

void _showHelpSheet(BuildContext context, AppLocalizations l) {
  final faqs = [
    (l.faqQuestion1, l.faqAnswer1), 
    (l.faqQuestion2, l.faqAnswer2),
    (l.faqQuestion3, l.faqAnswer3),
    (l.faqQuestion4, l.faqAnswer4),
    (l.faqQuestion5, l.faqAnswer5),
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (_, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(24),
        children: [
          Text(l.helpFaq,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...faqs.map((faq) => _FaqTile(
                question: faq.$1,
                answer: faq.$2,
              )),
        ],
      ),
    ),
  );
}

void _showReportSheet(BuildContext context, AppLocalizations l) {
  final controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.reportProblem,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: l.reportProblemHint, 
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.reportSent), 
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: Text(l.sendReport), 
            ),
          ),
        ],
      ),
    ),
  );
}
void _showPrivacySheet(BuildContext context, AppLocalizations l) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (_, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(24),
        children: [
          Text(l.privacyPolicy,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _PolicyText(
            title: l.privacyDataCollect,
            body: l.privacyDataCollectBody,
          ),
          _PolicyText(
            title: l.privacyDataUse,
            body: l.privacyDataUseBody,
          ),
          _PolicyText(
            title: l.privacyDataSecurity,
            body: l.privacyDataSecurityBody,
          ),
          _PolicyText(
            title: l.privacyYourRights,
            body: l.privacyYourRightsBody,
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

void _showTermsSheet(BuildContext context, AppLocalizations l) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (_, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(24),
        children: [
          Text(l.termsOfService,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _PolicyText(
            title: l.termsAcceptance,
            body: l.termsAcceptanceBody,
          ),
          _PolicyText(
            title: l.termsMedicalDisclaimer,
            body: l.termsMedicalDisclaimerBody,
          ),
          _PolicyText(
            title: l.termsUserResponsibilities,
            body: l.termsUserResponsibilitiesBody,
          ),
          _PolicyText(
            title: l.termsChanges,
            body: l.termsChangesBody,
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

}


// Helper Widgets


class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.neutral400,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: const TextStyle(fontSize: 12, color: AppColors.neutral400))
          : null,
      trailing: trailing ??
          (onTap != null
              ? const Icon(Icons.arrow_forward_ios,
                  size: 14, color: AppColors.neutral400)
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 56);
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.neutral400)),
            Text(value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}

class _FaqTile extends StatefulWidget {
  final String question;
  final String answer;
  const _FaqTile({required this.question, required this.answer});

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.question,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing: Icon(
              _open ? Icons.expand_less : Icons.expand_more,
              color: AppColors.primary,
            ),
            onTap: () => setState(() => _open = !_open),
          ),
          if (_open)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral600,
                      height: 1.5,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PolicyText extends StatelessWidget {
  final String title;
  final String body;
  const _PolicyText({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral600,
                    height: 1.6,
                  )),
        ],
      ),
    );
  }
}