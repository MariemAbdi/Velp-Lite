import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_model.dart';

class AuthState {
  final UserModel? user;
  final String? error;
  final bool isLoading;

  AuthState({this.user, this.error, this.isLoading = false});
}

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel() : super(AuthState());

  Future<bool> attemptLogin(UserModel user) async {
    state = AuthState(isLoading: true); // Show loading
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay
      if (user.email == "test@velp.com" && user.password == "123456") {
        state = AuthState(user: user, isLoading: false);
        return true;
      } else {
        state = AuthState(
            error: "Invalid email or password", isLoading: false); // Failure
        return false;
      }
    } catch (e) {
      state = AuthState(
          error: "Invalid email or password", isLoading: false); // Failure
      return false;
    }
  }

  void logout() {
    try {
      state = AuthState(user: null);
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }
}

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel();
});
