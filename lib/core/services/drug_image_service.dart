import 'package:dio/dio.dart';

/// Fetches real drug pill images from NLM RxImage via RxNorm lookup.
/// Flow: drug name → RxCUI (RxNorm API) → image URL (RxImage API)
/// Falls back gracefully if either call fails or returns no results.
class DrugImageService {
  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
  ));

  // Simple in-memory cache: drugName → imageUrl (or null if none found)
  static final Map<String, String?> _cache = {};

  static Future<String?> getImageUrl(String drugName) async {
    final key = drugName.toLowerCase().trim();
    if (_cache.containsKey(key)) return _cache[key];

    try {
      // Step 1: Get RxCUI from drug name
      final rxcui = await _getRxcui(key);
      if (rxcui == null) {
        _cache[key] = null;
        return null;
      }

      // Step 2: Get image URL from RxImage using RxCUI
      final imageUrl = await _getImageUrl(rxcui);
      _cache[key] = imageUrl;
      return imageUrl;
    } catch (_) {
      _cache[key] = null;
      return null;
    }
  }

  static Future<String?> _getRxcui(String name) async {
    try {
      final encoded = Uri.encodeComponent(name);
      final response = await _dio.get(
        'https://rxnav.nlm.nih.gov/REST/rxcui.json?name=$encoded&search=1',
      );
      final data = response.data as Map<String, dynamic>;
      final idGroup = data['idGroup'] as Map<String, dynamic>?;
      final ids = idGroup?['rxnormId'] as List<dynamic>?;
      if (ids == null || ids.isEmpty) return null;
      return ids.first.toString();
    } catch (_) {
      return null;
    }
  }

  static Future<String?> _getImageUrl(String rxcui) async {
    try {
      final response = await _dio.get(
        'https://rximage.nlm.nih.gov/api/rximage/1/rxnav?rxcui=$rxcui&resolution=600',
      );
      final data = response.data as Map<String, dynamic>;
      final images = data['nlmRxImages'] as List<dynamic>?;
      if (images == null || images.isEmpty) return null;
      return (images.first as Map<String, dynamic>)['imageUrl'] as String?;
    } catch (_) {
      return null;
    }
  }
}
