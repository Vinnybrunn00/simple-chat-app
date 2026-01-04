import 'package:ghost/core/contracts/contract_user.dart';

class Message implements ContractUser {
  final String _message;

  Message({required String message}) : _message = message;

  @override
  String get getValue => _message;

  @override
  void validate() {
    if (_message.isEmpty) {
      throw 'you need a message';
    }
  }
}
