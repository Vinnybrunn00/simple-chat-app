import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghost/utils/utils.dart';

class AuthServices {
  final String _username;
  final String _password;

  AuthServices({required String username, required String password})
    : _username = username,
      _password = password;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Utils _utils = Utils();

  Future<void> signIn() async {
    log(_username);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: '$_username@ghost.com',
        password: _password,
      );
    } on FirebaseException catch (error) {
      log(error.toString());
      throw error.message ?? 'Invalid Argument';
    }
  }

  Future<void> signUp() async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: '$_username@ghost.com',
            password: _password,
          );
      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(_username);

        await _firestore.collection('user').doc(user.uid).set({
          'id': user.uid,
          'username': _username,
          'password': _password,
          'createAccount': _utils.dateCreateAccountUser(),
        });
      }
      return;
    } on FirebaseException catch (error) {
      throw error.message ?? 'Invalid Argument';
    }
  }

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
