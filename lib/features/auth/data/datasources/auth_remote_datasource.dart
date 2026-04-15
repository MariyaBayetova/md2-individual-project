import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FlutterSecureStorage secureStorage;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.secureStorage,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    final token = await user.getIdToken();
    if (token != null) {
      await secureStorage.write(key: AppConstants.tokenKey, value: token);
    }
    await secureStorage.write(key: AppConstants.userIdKey, value: user.uid);
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> register(
      String email, String password, String name) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user!.updateDisplayName(name);
    await credential.user!.reload();
    final user = firebaseAuth.currentUser!;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    await secureStorage.deleteAll();
  }

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
