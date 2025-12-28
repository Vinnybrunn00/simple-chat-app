import 'package:ghost/constants/regex_password.dart';
import 'package:ghost/core/contracts/contract_user.dart';

class Username implements ContractUser {
  String _username;

  Username({required String username}) : _username = username;

  @override
  set setValue(String value) {
    _username = value;
  }

  @override
  String get getValue => _username;

  @override
  void validate() {
    if (_username.isEmpty) {
      throw 'Username cannot be empty';
    }
    if (_username.length <= 5) {
      throw 'Username too short, try another one.';
    }
    if (hasSpace.hasMatch(_username)) {
      throw 'The username cannot contain spaces.';
    }
  }
}
