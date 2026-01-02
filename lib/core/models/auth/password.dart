import 'package:ghost/constants/regex_password.dart';
import 'package:ghost/core/contracts/contract_user.dart';

class Password implements ContractUser {
  final String _password;

  Password({required String password}) : _password = password;

  @override
  String get getValue => _password;

  @override
  void validate() {
    if (_password.isEmpty) {
      throw 'Password cannot be empty';
    }
    if (_password.length <= 10) {
      throw 'Password too weak, try another';
    }
    if (hasSpace.hasMatch(_password)) {
      throw 'The password cannot contain spaces.';
    }

    final Map<bool, String> rules = {
      hasCharacter.hasMatch(_password):
          r'Must contain at least one special character. [@#$%^&*]',
      hasLowerCase.hasMatch(_password):
          'Must contain at least one capital letter',
      hasUpperCase.hasMatch(_password):
          'Must contain at least one capital latter',
      hasNumbers.hasMatch(_password): 'The password must contain numbers.',
    };

    for (final rule in rules.entries) {
      if (!rule.key) throw rule.value;
    }
  }
}
