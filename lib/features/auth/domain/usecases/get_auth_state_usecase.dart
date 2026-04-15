import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository repository;

  GetAuthStateUseCase(this.repository);

  Stream<User?> call() {
    return repository.authStateChanges;
  }
}