import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/services/drug_image_service.dart';
import '../../../../core/theme/app_colors.dart';

/// Loads a real drug photo from NLM RxImage.
/// Shows a colored fallback icon if no photo is available.
class DrugImageWidget extends StatefulWidget {
  final String drugName;
  final String dosageForm;
  final double size;
  final BorderRadius? borderRadius;

  const DrugImageWidget({
    super.key,
    required this.drugName,
    required this.dosageForm,
    this.size = 80,
    this.borderRadius,
  });

  @override
  State<DrugImageWidget> createState() => _DrugImageWidgetState();
}

class _DrugImageWidgetState extends State<DrugImageWidget> {
  String? _imageUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final url = await DrugImageService.getImageUrl(widget.drugName);
    if (mounted) setState(() { _imageUrl = url; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(12);

    if (_loading) {
      return ClipRRect(
        borderRadius: radius,
        child: Container(
          width: widget.size.isFinite ? widget.size : double.infinity,
          height: widget.size.isFinite ? widget.size : double.infinity,
          color: AppColors.primaryContainer,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      );
    }

    if (_imageUrl != null) {
      return ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: _imageUrl!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: widget.size,
            height: widget.size,
            color: AppColors.primaryContainer,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
          errorWidget: (_, __, ___) => _fallback(radius),
        ),
      );
    }

    return _fallback(radius);
  }

  Widget _fallback(BorderRadius radius) {
    final (icon, color) = _iconForForm(widget.dosageForm);
    // Never pass infinity as icon size — clamp to a safe max
    final safeSize = widget.size.isFinite ? widget.size : 120.0;
    final iconSize = safeSize * 0.45;
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        width: widget.size.isFinite ? widget.size : double.infinity,
        height: widget.size.isFinite ? widget.size : double.infinity,
        color: color.withValues(alpha: 0.12),
        child: Icon(icon, color: color, size: iconSize.isFinite ? iconSize : 54.0),
      ),
    );
  }

  (IconData, Color) _iconForForm(String form) {
    final f = form.toLowerCase();
    if (f.contains('capsule')) {
      return (Icons.medication_rounded, const Color(0xFF7C3AED));
    } else if (f.contains('liquid') || f.contains('solution') || f.contains('syrup')) {
      return (Icons.water_drop_outlined, AppColors.info);
    } else if (f.contains('cream') || f.contains('topical') || f.contains('gel')) {
      return (Icons.sanitizer_outlined, const Color(0xFFDB2777));
    } else if (f.contains('inhaler') || f.contains('aerosol')) {
      return (Icons.air_outlined, AppColors.success);
    } else if (f.contains('injection') || f.contains('injectable')) {
      return (Icons.vaccines_outlined, AppColors.error);
    }
    // Default: tablet
    return (Icons.medication_rounded, AppColors.primary);
  }
}
