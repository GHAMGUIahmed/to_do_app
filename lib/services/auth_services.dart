import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/model/User.dart';
import 'package:to_do/services/cloud_services.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? uu(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(user.uid, user.email, user.displayName);
  }

  Stream<UserModel?>? get user {
    return auth.authStateChanges().map(uu);
  }

  Future<UserModel?> SignInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return uu(credential.user);
    } catch (e) {
      throw FirebaseAuthException(code: "Wrong password");
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String displayName) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      await credential.user!
          .updateDisplayName(displayName)
          .then((value) => CloudService().CreateUser(email));
      await credential.user!.reload();
      return auth.currentUser;
    } else {
      throw FirebaseAuthException(
        code: 'user-creation-failed',
        message: 'Failed to create user',
      );
    }
  }

  Future<void> singOut() async {
    return await auth.signOut();
  }
}
