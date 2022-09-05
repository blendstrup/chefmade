import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<dynamic> login(
    FirebaseAuth auth,
    String userEmail,
    String userPassword,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'ERROR_WRONG_PASSWORD':
        case 'wrong-password':
          return {'code': e.code, 'msg': 'Wrong password.'};
        case 'ERROR_USER_NOT_FOUND':
        case 'user-not-found':
          return {'code': e.code, 'msg': 'No user found with this email.'};
        case 'ERROR_USER_DISABLED':
        case 'user-disabled':
          return {'code': e.code, 'msg': 'This user has been disabled.'};
        case 'ERROR_INVALID_EMAIL':
        case 'invalid-email':
          return {'code': e.code, 'msg': 'Email address is invalid.'};
        default:
          return {'code': e.code, 'msg': 'Login failed. Please try again.'};
      }

      //case 'ERROR_EMAIL_ALREADY_IN_USE':
      //case 'account-exists-with-different-credential':
      //case 'email-already-in-use':
      //  return {'msg': 'Email already used. Go to login page.'};
      //case 'ERROR_TOO_MANY_REQUESTS':
      //  return {
      //    'code': e.code,
      //    'msg': 'Too many requests to log into this account.'
      //  };
      //case 'ERROR_OPERATION_NOT_ALLOWED':
      //case 'operation-not-allowed':
      //  return {
      //    'code': e.code,
      //    'msg': 'Server error, please try again later.'
      //  };
    }
  }

  static Future<void> logout(FirebaseAuth auth) async {
    await auth.signOut();
  }

  static User? getCurrentUser(FirebaseAuth auth) {
    return auth.currentUser;
  }
}
