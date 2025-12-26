import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghost/utils/utils.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Utils _utils = Utils();

  Future<void> signInAndSignup({
    required String username,
    required String password,
    required bool isLogin,
  }) async {
    try {
      if (isLogin) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: '$username@ghost.com',
          password: password,
        );
        return;
      }

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: '$username@ghost.com',
            password: password,
          );

      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(username);

        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'username': username,
          'password': password,
          'createAccount': _utils.dateCreateAccountUser(),
        });
      }
      return;
    } on FirebaseAuthException catch (err) {
      throw err.message ?? 'Invalid Argument';
    }
  }
}
