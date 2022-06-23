import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' show Opacity, CupertinoIcons;
import 'package:flutter/material.dart' show Icons, IconData;
import 'package:overlay_support/overlay_support.dart';

import '../../interface/widgets/common/toast.dart';
import '../remote/auth_service.dart';

abstract class IAuthRepository {
  Future<void> logout();

  Future<Map<String, String>?> login(String email, String password);

  User? getCurrentUser();

  Stream<User?> authStateChanges();
}

class AuthRepository implements IAuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<void> logout() async {
    await AuthService.logout(_auth);

    IconData _platformLogoutIcon =
        Platform.isIOS ? CupertinoIcons.lock : Icons.logout;

    showOverlay(
      (context, t) => Opacity(
        opacity: t,
        child: AppToast(
          'You have logged out',
          icon: _platformLogoutIcon,
        ),
      ),
    );
  }

  @override
  Future<Map<String, String>?> login(
    String userEmail,
    String userPassword,
  ) async {
    return await AuthService.login(_auth, userEmail, userPassword);
  }

  @override
  User? getCurrentUser() {
    return AuthService.getCurrentUser(_auth);
  }

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
