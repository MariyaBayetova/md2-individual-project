import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<UserEntity> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Login failed');
    }

    // Получаем данные из Firestore
    final doc = await _firestore.collection('users').doc(credential.user!.uid).get();

    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }

    // Если данных нет в Firestore, создаём из Firebase User
    return UserModel.fromFirebaseUser(credential.user!);
  }

  @override
  Future<UserEntity> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Registration failed');
    }

    final user = UserModel(
      id: credential.user!.uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    // Сохраняем в Firestore
    await _firestore.collection('users').doc(user.id).set(user.toJson());

    // Обновляем displayName в Firebase Auth
    await credential.user!.updateDisplayName(user.fullName);

    return user;
  }

  @override
  Future<void> logout() => _auth.signOut();

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  UserEntity? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user);
  }
}