import 'package:ghost/constants/regex_password.dart';
import 'package:ghost/core/contracts/contract_user.dart';

class Password implements ContractUser {
  String _password;

  Password({required String password}) : _password = password;

  @override
  set setValue(String value) {
    _password = value;
  }

  @override
  String get getValue => _password;

  @override
  void validate() {
    if (_password.isEmpty) {
      throw 'Password cannot be empty';
    }
    if (_password.length <= 10) {
      throw 'Password too Weak, try another.';
    }
    if (!hasSpecialCharacter.hasMatch(_password)) {
      throw r'Must contain at least one special character. [@#$%^&*]';
    }
    if (!hasLowerCase.hasMatch(_password)) {
      throw 'Must contain at least one lowercase letter';
    }
    if (!hasUpperCase.hasMatch(_password)) {
      throw 'Must contain at least one capital letter';
    }
    if (hasSpace.hasMatch(_password)) {
      throw 'The password cannot contain spaces.';
    }
    if (!hasNumbers.hasMatch(_password)) {
      throw 'The password must contain numbers.';
    }
  }
}
