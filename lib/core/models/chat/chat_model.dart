import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghost/core/models/chat/message.dart';
import 'package:intl/intl.dart' as intl;

class UserChatModel {
  Message message = Message(message: '');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  int get _messageId {
    final math.Random random = math.Random();
    return random.nextInt(999999999 - 100000000);
  }

  int get _timeStampMessage {
    DateTime now = DateTime.now();
    int timeStampNow = now.millisecondsSinceEpoch;
    return timeStampNow;
  }

  String? dateFormatBubble(dynamic timestamp) {
    if (timestamp != null) {
      return intl.DateFormat(
        "dd/MM/yyyy HH:mm",
      ).format((timestamp as Timestamp).toDate()).toString();
    }
    return null;
  }

  String? get displayName => currentUser?.displayName;
  String? get uid => currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get _messages =>
      _firestore.collection('chat').doc('22112000').collection('messages');

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMessages() {
    return _messages.orderBy('timestamp', descending: false).snapshots();
  }

  Future<void> sendMessage(String message) async {
    try {
      await _messages.doc('$_messageId').set({
        'uid': uid,
        'username': displayName,
        'message': message,
        'time': DateTime.now(),
        'timestamp': _timeStampMessage,
      });
    } on FirebaseAuthException catch (err) {
      throw err.message ?? 'Unknow Error';
    }
  }
}
