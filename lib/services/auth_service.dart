import 'package:flutter/foundation.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Mocking for now
import '../models/user_model.dart';
import '../services/preferences_service.dart';

// Mock Credential
class UserCredential {
  final User? user;
  UserCredential({this.user});
}

class User {
  final String uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;

  User({required this.uid, this.email, this.displayName, this.phoneNumber});
}

class AuthService extends ChangeNotifier {
  User? _user;
  UserModel? _userProfile;

  User? get currentUser => _user;
  UserModel? get userProfile => _userProfile;

  // Mock Sign Up
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    _user = User(uid: 'mock_uid_123', email: email);
    notifyListeners();
    return UserCredential(user: _user);
  }

  // Mock Sign In
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate finding a profile
    _user = User(uid: 'mock_uid_123', email: email);
    if (_userProfile == null) {
      // Create basic profile if not exists in memory
      _userProfile = UserModel(
        id: 'mock_uid_123',
        name: 'Test User',
        age: 25,
        phone: '1234567890',
        email: email,
      );
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    _userProfile = null;
    notifyListeners();
  }

  Future<void> createProfile(UserModel user) async {
    _userProfile = user;
    notifyListeners();
  }

  Future<void> updateProfile(UserModel user) async {
    _userProfile = user;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    // Mock
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // Mock
  }
}
