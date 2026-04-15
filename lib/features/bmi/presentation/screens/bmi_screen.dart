import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  double _height = 170; // cm
  double _weight = 70;  // kg
  double? _bmi;
  String _gender = 'Female';

  void _calculate() {
    final h = _height / 100;
    setState(() => _bmi = _weight / (h * h));
  }

  String get _category {
    if (_bmi == null) return '';
    if (_bmi! < 18.5) return 'Underweight';
    if (_bmi! < 25.0) return 'Normal';
    if (_bmi! < 30.0) return 'Overweight';
    return 'Obese';
  }

  Color get _categoryColor {
    if (_bmi == null) return AppColors.neutral400;
    if (_bmi! < 18.5) return AppColors.info;
    if (_bmi! < 25.0) return AppColors.success;
    if (_bmi! < 30.0) return AppColors.warning;
    return AppColors.error;
  }

  String get _advice {
    if (_bmi == null) return '';
    if (_bmi! < 18.5) {
      return 'You are underweight. Consider a nutrient-rich diet and consult your doctor.';
    } else if (_bmi! < 25.0) {
      return 'Great! You have a healthy weight. Keep up your current lifestyle.';
    } else if (_bmi! < 30.0) {
      return 'You are slightly overweight. Regular exercise and a balanced diet can help.';
    }
    return 'Your BMI indicates obesity. Please consult a doctor for a personalised plan.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gender selector
            Text('Gender',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Row(
              children: ['Female', 'Male'].map((g) {
                final selected = _gender == g;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _gender = g),
                    child: Container(
                      margin: EdgeInsets.only(
                          right: g == 'Female' ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Text(
                            g == 'Female' ? '👩' : '👨',
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            g,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Height slider
            _SliderCard(
              label: 'Height',
              value: _height,
              unit: 'cm',
              min: 100,
              max: 220,
              onChanged: (v) => setState(() => _height = v),
            ),
            const SizedBox(height: 16),

            // Weight slider
            _SliderCard(
              label: 'Weight',
              value: _weight,
              unit: 'kg',
              min: 30,
              max: 200,
              onChanged: (v) => setState(() => _weight = v),
            ),
            const SizedBox(height: 28),

            // Calculate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            // Result card
            if (_bmi != null) ...[
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _categoryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _categoryColor.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      _bmi!.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                        color: _categoryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _category,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _categoryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _advice,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: AppColors.neutral600,
                            height: 1.5,
                          ),
                    ),
                    const SizedBox(height: 16),
                    // BMI scale bar
                    _BmiScaleBar(bmi: _bmi!),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // BMI reference table
              _ReferenceTable(),
            ],
          ],
        ),
      ),
    );
  }
}

class _SliderCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        fontFamily: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: ' $unit',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.neutral400,
                        fontFamily: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primaryContainer,
              thumbColor: AppColors.primary,
              overlayColor:
                  AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${min.toInt()} $unit',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.neutral400)),
              Text('${max.toInt()} $unit',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.neutral400)),
            ],
          ),
        ],
      ),
    );
  }
}

class _BmiScaleBar extends StatelessWidget {
  final double bmi;
  const _BmiScaleBar({required this.bmi});

  @override
  Widget build(BuildContext context) {
    // Clamp position between 10 and 40 for display
    final clamped = bmi.clamp(10.0, 40.0);
    final position = (clamped - 10) / 30;

    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(height: 8, color: AppColors.info)),
                  Expanded(
                      flex: 3,
                      child: Container(height: 8, color: AppColors.success)),
                  Expanded(
                      flex: 2,
                      child: Container(height: 8, color: AppColors.warning)),
                  Expanded(
                      flex: 2,
                      child: Container(height: 8, color: AppColors.error)),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment(position * 2 - 1, 0),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('10', style: TextStyle(fontSize: 10, color: AppColors.neutral400)),
            Text('25', style: TextStyle(fontSize: 10, color: AppColors.neutral400)),
            Text('40', style: TextStyle(fontSize: 10, color: AppColors.neutral400)),
          ],
        ),
      ],
    );
  }
}

class _ReferenceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = [
      ('< 18.5', 'Underweight', AppColors.info),
      ('18.5 – 24.9', 'Normal weight', AppColors.success),
      ('25.0 – 29.9', 'Overweight', AppColors.warning),
      ('≥ 30.0', 'Obese', AppColors.error),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('BMI Reference',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const Divider(height: 1),
          ...rows.map((r) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: r.$3, shape: BoxShape.circle)),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: 100,
                        child: Text(r.$1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600))),
                    Text(r.$2,
                        style: TextStyle(
                            fontSize: 13, color: AppColors.neutral600)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
