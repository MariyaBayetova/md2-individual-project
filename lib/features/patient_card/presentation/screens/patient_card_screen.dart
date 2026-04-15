// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/offline_banner.dart';
// import '../../../../core/widgets/state_widgets.dart';
// import '../../../auth/presentation/providers/auth_providers.dart';
// import '../../domain/entities/patient_entity.dart';
// import '../providers/patient_providers.dart';

// class PatientCardScreen extends ConsumerWidget {
//   const PatientCardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final patientAsync = ref.watch(patientNotifierProvider);
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(l.patientCard),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings_outlined),
//             tooltip: l.settings,
//             onPressed: () => context.push('/settings'),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: l.logout,
//             onPressed: () async {
//               await ref.read(authNotifierProvider.notifier).logout();
//               if (context.mounted) context.go(Routes.login);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const OfflineBanner(),
//           Expanded(
//             child: patientAsync.when(
//               loading: () => const ShimmerList(count: 4, itemHeight: 80),
//               error: (e, _) => ErrorView(
//                 message: e.toString(),
//                 onRetry: () => ref.invalidate(patientNotifierProvider),
//               ),
//               data: (patient) {
//                 final p = patient ??
//                     PatientEntity(
//                       id: user?.uid ?? '',
//                       fullName: user?.displayName ?? 'Unknown',
//                       email: user?.email ?? '',
//                     );
//                 return _PatientCardBody(patient: p);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PatientCardBody extends ConsumerStatefulWidget {
//   final PatientEntity patient;
//   const _PatientCardBody({required this.patient});

//   @override
//   ConsumerState<_PatientCardBody> createState() => _PatientCardBodyState();
// }

// class _PatientCardBodyState extends ConsumerState<_PatientCardBody> {
//   late PatientEntity _patient;
//   bool _editing = false;
//   final _nameCtrl = TextEditingController();
//   String? _selectedBloodType;
//   final List<String> _allergies = [];
//   final _allergyCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _patient = widget.patient;
//     _nameCtrl.text = _patient.fullName;
//     _selectedBloodType = _patient.bloodType;
//     _allergies.addAll(_patient.allergies);
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _allergyCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _save() async {
//     final updated = _patient.copyWith(
//       fullName: _nameCtrl.text.trim(),
//       bloodType: _selectedBloodType,
//       allergies: List.from(_allergies),
//     );
//     await ref.read(patientNotifierProvider.notifier).updatePatient(updated);
//     if (!mounted) return;
//     setState(() {
//       _patient = updated;
//       _editing = false;
//     });
//     final l = AppLocalizations.of(context)!;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(l.profileSaved)),
//     );
//   }

//   Future<void> _pickAndUploadDocument() async {
//     final picker = ImagePicker();
//     final file = await picker.pickImage(source: ImageSource.gallery);
//     if (file == null) return;
//     ref.read(isUploadingDocProvider.notifier).state = true;
//     try {
//       await ref
//           .read(patientNotifierProvider.notifier)
//           .uploadDocument(File(file.path));
//       if (mounted) {
//         final l = AppLocalizations.of(context)!;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(l.documentUploaded)),
//         );
//       }
//     } finally {
//       ref.read(isUploadingDocProvider.notifier).state = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context)!;
//     final isUploading = ref.watch(isUploadingDocProvider);
//     final updatedPatient =
//         ref.watch(patientNotifierProvider).asData?.value ?? _patient;

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 48,
//                   backgroundColor: AppColors.primaryContainer,
//                   backgroundImage: updatedPatient.avatarUrl != null
//                       ? CachedNetworkImageProvider(updatedPatient.avatarUrl!)
//                       : null,
//                   child: updatedPatient.avatarUrl == null
//                       ? Text(
//                           (updatedPatient.fullName.isNotEmpty
//                                   ? updatedPatient.fullName[0]
//                                   : '?')
//                               .toUpperCase(),
//                           style: const TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.primary),
//                         )
//                       : null,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(updatedPatient.fullName,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(fontWeight: FontWeight.w700)),
//                 Text(updatedPatient.email,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall
//                         ?.copyWith(color: AppColors.neutral400)),
//               ],
//             ),
//           ),
//           const SizedBox(height: 28),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(l.personalInfo,
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall
//                       ?.copyWith(fontWeight: FontWeight.w700)),
//               TextButton.icon(
//                 onPressed:
//                     _editing ? _save : () => setState(() => _editing = true),
//                 icon: Icon(_editing ? Icons.check : Icons.edit, size: 16),
//                 label: Text(_editing ? l.save : l.edit),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           if (_editing)
//             TextField(
//               controller: _nameCtrl,
//               decoration: InputDecoration(
//                 labelText: l.fullName,
//                 prefixIcon: const Icon(Icons.person_outline),
//               ),
//             )
//           else
//             _InfoTile(label: l.fullName, value: updatedPatient.fullName),
//           const SizedBox(height: 12),
//           _SectionTitle(l.medicalInformation),
//           const SizedBox(height: 12),
//           if (_editing)
//             DropdownButtonFormField<String>(
//               value: _selectedBloodType,
//               decoration: InputDecoration(labelText: l.bloodType),
//               items: AppConstants.bloodTypes
//                   .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
//                   .toList(),
//               onChanged: (v) => setState(() => _selectedBloodType = v),
//             )
//           else
//             _InfoTile(
//               label: l.bloodType,
//               value: updatedPatient.bloodType ?? l.notSet,
//               icon: Icons.bloodtype_outlined,
//             ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _SectionTitle(l.allergies),
//               if (_editing)
//                 IconButton(
//                   onPressed: _showAddAllergyDialog,
//                   icon: const Icon(Icons.add_circle_outline,
//                       color: AppColors.primary),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           if (_allergies.isEmpty)
//             Text(l.none, style: const TextStyle(color: AppColors.neutral400))
//           else
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: _allergies
//                   .map((a) => Chip(
//                         label: Text(a),
//                         onDeleted: _editing
//                             ? () => setState(() => _allergies.remove(a))
//                             : null,
//                         backgroundColor: AppColors.primaryContainer,
//                         labelStyle: const TextStyle(
//                             color: AppColors.primary, fontSize: 12),
//                       ))
//                   .toList(),
//             ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _SectionTitle(l.documents),
//               if (isUploading)
//                 const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(strokeWidth: 2))
//               else
//                 IconButton(
//                   onPressed: _pickAndUploadDocument,
//                   icon: const Icon(Icons.upload_file, color: AppColors.primary),
//                   tooltip: l.uploadDocument,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           if (updatedPatient.documentUrls.isEmpty)
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               alignment: Alignment.center,
//               child: Column(children: [
//                 const Icon(Icons.folder_open_outlined,
//                     size: 40, color: AppColors.neutral400),
//                 const SizedBox(height: 8),
//                 Text(l.noDocuments,
//                     style: const TextStyle(
//                         color: AppColors.neutral400, fontSize: 13)),
//               ]),
//             )
//           else
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: updatedPatient.documentUrls.length,
//               itemBuilder: (_, i) => ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: const Icon(Icons.insert_drive_file_outlined,
//                     color: AppColors.primary),
//                 title: Text('Document ${i + 1}',
//                     style: const TextStyle(fontSize: 13)),
//                 subtitle: Text(
//                   updatedPatient.documentUrls[i],
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       fontSize: 11, color: AppColors.neutral400),
//                 ),
//               ),
//             ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }

//   void _showAddAllergyDialog() {
//     final l = AppLocalizations.of(context)!;
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(l.addAllergy),
//         content: TextField(
//           controller: _allergyCtrl,
//           decoration: InputDecoration(hintText: l.allergyHint),
//           autofocus: true,
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(ctx),
//               child: Text(l.cancel)),
//           ElevatedButton(
//             onPressed: () {
//               final val = _allergyCtrl.text.trim();
//               if (val.isNotEmpty) {
//                 setState(() => _allergies.add(val));
//                 _allergyCtrl.clear();
//               }
//               Navigator.pop(ctx);
//             },
//             child: Text(l.add),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _InfoTile extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData? icon;
//   const _InfoTile({required this.label, required this.value, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.neutral200),
//       ),
//       child: Row(children: [
//         if (icon != null) ...[
//           Icon(icon, color: AppColors.primary, size: 20),
//           const SizedBox(width: 10),
//         ],
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(label,
//               style: const TextStyle(fontSize: 11, color: AppColors.neutral400)),
//           Text(value,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//         ]),
//       ]),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   const _SectionTitle(this.title);

//   @override
//   Widget build(BuildContext context) => Text(
//         title,
//         style: Theme.of(context)
//             .textTheme
//             .titleSmall
//             ?.copyWith(fontWeight: FontWeight.w700),
//       );
// }



import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/patient_entity.dart';
import '../providers/patient_providers.dart';

class PatientCardScreen extends ConsumerWidget {
  const PatientCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final patientAsync = ref.watch(patientNotifierProvider);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.patientCard),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l.settings,
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l.logout,
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) context.go(Routes.login);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: patientAsync.when(
              loading: () => const ShimmerList(count: 4, itemHeight: 80),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(patientNotifierProvider),
              ),
              data: (patient) {
                final p = patient ??
                    PatientEntity(
                      id: user?.uid ?? '',
                      fullName: user?.displayName ?? 'Unknown',
                      email: user?.email ?? '',
                    );
                return _PatientCardBody(patient: p);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientCardBody extends ConsumerStatefulWidget {
  final PatientEntity patient;
  const _PatientCardBody({required this.patient});

  @override
  ConsumerState<_PatientCardBody> createState() => _PatientCardBodyState();
}

class _PatientCardBodyState extends ConsumerState<_PatientCardBody> {
  late PatientEntity _patient;
  bool _editing = false;
  final _nameCtrl = TextEditingController();
  String? _selectedBloodType;
  final List<String> _allergies = [];
  final _allergyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _patient = widget.patient;
    _nameCtrl.text = _patient.fullName;
    _selectedBloodType = _patient.bloodType;
    _allergies.addAll(_patient.allergies);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _allergyCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final updated = _patient.copyWith(
      fullName: _nameCtrl.text.trim(),
      bloodType: _selectedBloodType,
      allergies: List.from(_allergies),
    );
    await ref.read(patientNotifierProvider.notifier).updatePatient(updated);
    if (!mounted) return;
    setState(() {
      _patient = updated;
      _editing = false;
    });
    final l = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.profileSaved)),
    );
  }

  Future<void> _pickAndUploadDocument() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    ref.read(isUploadingDocProvider.notifier).state = true;
    try {
      await ref
          .read(patientNotifierProvider.notifier)
          .uploadDocument(File(file.path));
      if (mounted) {
        final l = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.documentUploaded)),
        );
      }
    } finally {
      ref.read(isUploadingDocProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isUploading = ref.watch(isUploadingDocProvider);
    final updatedPatient =
        ref.watch(patientNotifierProvider).asData?.value ?? _patient;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: updatedPatient.avatarUrl != null
                      ? CachedNetworkImageProvider(updatedPatient.avatarUrl!)
                      : null,
                  child: updatedPatient.avatarUrl == null
                      ? Text(
                          (updatedPatient.fullName.isNotEmpty
                                  ? updatedPatient.fullName[0]
                                  : '?')
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                Text(updatedPatient.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                Text(updatedPatient.email,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.neutral400)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l.personalInfo,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              TextButton.icon(
                onPressed:
                    _editing ? _save : () => setState(() => _editing = true),
                icon: Icon(_editing ? Icons.check : Icons.edit, size: 16),
                label: Text(_editing ? l.save : l.edit),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_editing)
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: l.fullName,
                prefixIcon: const Icon(Icons.person_outline),
              ),
            )
          else
            _InfoTile(label: l.fullName, value: updatedPatient.fullName),
          const SizedBox(height: 12),
          _SectionTitle(l.medicalInformation),
          const SizedBox(height: 12),
          if (_editing)
            DropdownButtonFormField<String>(
              value: _selectedBloodType,
              decoration: InputDecoration(labelText: l.bloodType),
              items: AppConstants.bloodTypes
                  .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBloodType = v),
            )
          else
            _InfoTile(
              label: l.bloodType,
              value: updatedPatient.bloodType ?? l.notSet,
              icon: Icons.bloodtype_outlined,
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SectionTitle(l.allergies),
              if (_editing)
                IconButton(
                  onPressed: _showAddAllergyDialog,
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.primary),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (_allergies.isEmpty)
            Text(l.none, style: const TextStyle(color: AppColors.neutral400))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allergies
                  .map((a) => Chip(
                        label: Text(a),
                        onDeleted: _editing
                            ? () => setState(() => _allergies.remove(a))
                            : null,
                        backgroundColor: AppColors.primaryContainer,
                        labelStyle: const TextStyle(
                            color: AppColors.primary, fontSize: 12),
                      ))
                  .toList(),
            ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SectionTitle(l.documents),
              if (isUploading)
                const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
              else
                IconButton(
                  onPressed: _pickAndUploadDocument,
                  icon: const Icon(Icons.upload_file, color: AppColors.primary),
                  tooltip: l.uploadDocument,
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (updatedPatient.documentUrls.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Column(children: [
                const Icon(Icons.folder_open_outlined,
                    size: 40, color: AppColors.neutral400),
                const SizedBox(height: 8),
                Text(l.noDocuments,
                    style: const TextStyle(
                        color: AppColors.neutral400, fontSize: 13)),
              ]),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: updatedPatient.documentUrls.length,
              itemBuilder: (_, i) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.insert_drive_file_outlined,
                    color: AppColors.primary),
                title: Text('${l.document} ${i + 1}',
                    style: const TextStyle(fontSize: 13)),
                subtitle: Text(
                  updatedPatient.documentUrls[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.neutral400),
                ),
              ),
            ),
          const SizedBox(height: 24),

          _SectionTitle(l.healthTools),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/bmi'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDB2777).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.monitor_weight_outlined,
                            color: Color(0xFFDB2777), size: 28),
                        const SizedBox(height: 8),
                        Text(l.bmiCalculator,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xFFDB2777))),
                        const SizedBox(height: 2),
                        Text(l.bmiCalculatorDescription,
                            style: TextStyle(
                                fontSize: 11,
                                color: const Color(0xFFDB2777)
                                    .withOpacity(0.7))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/reminders'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.alarm_outlined,
                            color: AppColors.warning, size: 28),
                        const SizedBox(height: 8),
                        Text(l.medicineReminders,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: AppColors.warning)),
                        const SizedBox(height: 2),
                        Text(l.trackMedications,
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.warning.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => context.push('/my-reviews'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: const Color(0xFF7C3AED).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF7C3AED), size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.myReviews,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.myReviewsDescription,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF7C3AED), size: 14),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showAddAllergyDialog() {
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.addAllergy),
        content: TextField(
          controller: _allergyCtrl,
          decoration: InputDecoration(hintText: l.allergyHint),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          ElevatedButton(
            onPressed: () {
              final val = _allergyCtrl.text.trim();
              if (val.isNotEmpty) {
                setState(() => _allergies.add(val));
                _allergyCtrl.clear();
              }
              Navigator.pop(ctx);
            },
            child: Text(l.add),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  const _InfoTile({required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(children: [
        if (icon != null) ...[
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
        ],
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: AppColors.neutral400)),
          Text(value,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w700),
      );
}
