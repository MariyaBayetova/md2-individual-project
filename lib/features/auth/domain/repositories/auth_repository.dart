import 'package:firebase_auth/firebase_auth.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(
    String email,
    String password,
    String firstName,
    String lastName,
  );
  Future<void> logout();
  Stream<User?> get authStateChanges;
  UserEntity? getCurrentUser();
}