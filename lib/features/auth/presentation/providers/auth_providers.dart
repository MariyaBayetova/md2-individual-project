import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_auth_state_usecase.dart';

/// Firebase auth state stream
final authStateProvider = StreamProvider<User?>((ref) {
  return sl<GetAuthStateUseCase>().call();
});

/// Auth notifier (login / register / logout)
class AuthNotifier extends AsyncNotifier<UserEntity?> {
  @override
  Future<UserEntity?> build() async => null;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => sl<LoginUseCase>().call(email, password),
    );
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => sl<RegisterUseCase>().call(email, password, firstName, lastName),
    );
  }

  Future<void> logout() async {
    await sl<LogoutUseCase>().call();
    state = const AsyncData(null);
  }
}

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, UserEntity?>(() => AuthNotifier());