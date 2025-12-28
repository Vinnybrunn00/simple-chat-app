import 'package:ghost/core/contracts/contract_user.dart';

class Message implements ContractUser {
  String _message;

  Message({required String message}) : _message = message;

  @override
  set setValue(String value) {
    _message = value;
  }

  @override
  String get getValue => _message;

  @override
  void validate() {
    if (_message.isEmpty) {
      throw 'you need a message';
    }
  }
}
