import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/drug_entity.dart';
import '../../domain/usecases/get_popular_drugs_usecase.dart';
import '../../domain/usecases/search_drugs_usecase.dart';

// ── Search query ──────────────────────────────────────────────────────────────
final drugSearchQueryProvider = StateProvider<String>((ref) => '');

// ── Popular drugs (cache-then-network) ────────────────────────────────────────
final popularDrugsProvider = FutureProvider<List<DrugEntity>>((ref) async {
  return sl<GetPopularDrugsUseCase>().call();
});

// ── Search results ─────────────────────────────────────────────────────────────
final drugSearchResultsProvider =
    FutureProvider.family<List<DrugEntity>, String>((ref, query) async {
  if (query.trim().isEmpty) return ref.watch(popularDrugsProvider.future);
  return sl<SearchDrugsUseCase>().call(query);
});

// ── Displayed drugs ────────────────────────────────────────────────────────────
final displayedDrugsProvider = Provider<AsyncValue<List<DrugEntity>>>((ref) {
  final query = ref.watch(drugSearchQueryProvider);
  return ref.watch(drugSearchResultsProvider(query));
});

// ── Cart ───────────────────────────────────────────────────────────────────────
class CartNotifier extends StateNotifier<List<CartItemEntity>> {
  CartNotifier() : super([]);

  void addItem(DrugEntity drug) {
    final idx = state.indexWhere((i) => i.drug.id == drug.id);
    if (idx >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == idx)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItemEntity(drug: drug, quantity: 1)];
    }
  }

  void removeItem(String drugId) {
    state = state.where((i) => i.drug.id != drugId).toList();
  }

  void decrementItem(String drugId) {
    final idx = state.indexWhere((i) => i.drug.id == drugId);
    if (idx < 0) return;
    if (state[idx].quantity <= 1) {
      removeItem(drugId);
    } else {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == idx)
            state[i].copyWith(quantity: state[i].quantity - 1)
          else
            state[i],
      ];
    }
  }

  void clear() => state = [];
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItemEntity>>(
  (_) => CartNotifier(),
);

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, i) => sum + i.totalPrice);
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, i) => sum + i.quantity);
});

// ── Order placement state ──────────────────────────────────────────────────────
final orderPlacedProvider = StateProvider<bool>((ref) => false);
