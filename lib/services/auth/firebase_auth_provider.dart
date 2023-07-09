// import 'package:firebase_core/firebase_core.dart';
// import 'package:health_care/firebase_options.dart';
import 'package:health_care/screens/general/toast_notification.dart';
import 'package:health_care/services/auth/auth_provider.dart';
import 'package:health_care/services/auth/auth_user.dart';
import 'package:health_care/services/auth/auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              ToastNotification().showToast("Register successfully!", true));
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          {
            ToastNotification().showToast("Weak password", false);
            throw WeakPasswordAuthException();
          }
        case 'email-already-in-use':
          {
            ToastNotification().showToast("Email already in use", false);
            throw EmailAlreadyInUseAuthException();
          }
        case 'invalid-email':
          {
            ToastNotification().showToast("Invalid email", false);
            throw InvalidEmailAuthException();
          }
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              ToastNotification().showToast("Login successfully!", true));
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          {
            ToastNotification().showToast("User not found", false);
            throw UserNotFoundAuthException();
          }
        case 'wrong-password':
          {
            ToastNotification().showToast("Wrong password", false);
            throw UserNotFoundAuthException();
          }
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
